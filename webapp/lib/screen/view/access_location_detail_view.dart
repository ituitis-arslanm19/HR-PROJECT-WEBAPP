import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/widgets/other/drop_down_input_text.dart';
import 'package:webapp/core/widgets/other/simple_container.dart';

import '../../core/constant/enum/enums.dart';
import '../../core/network/network_manager.dart';
import '../../core/util/size_config.dart';
import '../../core/widgets/other/input_text2.dart';
import '../service/access_location_service.dart';
import '../service/site_service.dart';
import '../viewModel/access_location_detail_view_model.dart';

class AccessLocationDetailView extends StatelessWidget {
  final int? id;
  final BuildContext buildContext;
  const AccessLocationDetailView(
      {super.key, required this.id, required this.buildContext});

  @override
  Widget build(BuildContext context) {
    AccessLocationDetailViewModel viewModel = AccessLocationDetailViewModel(
        AccessLocationService(networkManager: NetworkManager()),
        SiteService(networkManager: NetworkManager()),
        id,
        context);
    viewModel.init();

    return buildPopUp(context, viewModel);
  }

  buildPopUp(BuildContext context, AccessLocationDetailViewModel viewModel) {
    return Observer(builder: (_) {
      switch (viewModel.dataState) {
        case DataState.LOADING:
          return const Center(child: CircularProgressIndicator());
        case DataState.ERROR:
          return const Center(
              child:
                  Text("Giriş noktası detayı görüntülenirken bir hata oluştu"));
        default:
          return SizedBox(
            width: SizeConfig.blockSizeHorizontal * 30,
            height: SizeConfig.blockSizeVertical * 33,
            child: SimpleContainer(
              padding: 0,
              title: "Giriş Noktası",
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: InputText2(
                              icon: const Icon(Icons.room),
                              hintText: "Ad",
                              textEditingController:
                                  viewModel.textEditingControllerList[0])),
                      Expanded(
                          flex: 5,
                          child: InputText2(
                              icon: const Icon(Icons.control_point),
                              hintText: "Tip",
                              textEditingController:
                                  viewModel.textEditingControllerList[1])),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: DropDownInputText(
                            title: "Alan",
                            textEditingController: TextEditingController(
                                text: viewModel.accessLocationDetail!.siteId !=
                                        null
                                    ? viewModel.siteList!
                                            .firstWhere((element) =>
                                                element.id ==
                                                viewModel.accessLocationDetail!
                                                    .siteId)
                                            .name ??
                                        ""
                                    : ""),
                            items:
                                viewModel.siteList!.map((e) => e.name).toList(),
                            onTap: (index) {
                              viewModel.accessLocationDetail!.siteId =
                                  viewModel.siteList![index].id;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 5,
                          child: InputText2(
                              icon: const Icon(Icons.location_searching),
                              hintText: "Konum",
                              textEditingController:
                                  viewModel.textEditingControllerList[2])),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: SizeConfig.screenHeight * 0.04,
                          width: SizeConfig.screenWidth * 0.05,
                          child: TextButton(
                              onPressed: () async {
                                if (await viewModel.updateAccessLocation()) {
                                  Navigator.pop(buildContext);
                                }
                              },
                              child: const Text("Kaydet",
                                  style: TextStyle(color: Colors.white)),
                              style: TextButton.styleFrom(
                                  backgroundColor: Theme.of(buildContext)
                                      .colorScheme
                                      .primary)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: SizeConfig.screenHeight * 0.04,
                          width: SizeConfig.screenWidth * 0.05,
                          child: TextButton(
                              onPressed: () => Navigator.of(buildContext).pop(),
                              child: const Text("İptal",
                                  style: TextStyle(color: Colors.white)),
                              style: TextButton.styleFrom(
                                  backgroundColor: Theme.of(buildContext)
                                      .colorScheme
                                      .primary)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
      }
    });
  }
}
