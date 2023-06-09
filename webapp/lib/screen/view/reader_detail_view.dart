import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../core/constant/enum/enums.dart';
import '../../core/network/network_manager.dart';
import '../../core/util/size_config.dart';
import '../../core/widgets/other/drop_down_input_text.dart';
import '../../core/widgets/other/input_text2.dart';
import '../../core/widgets/other/simple_container.dart';
import '../service/access_location_service.dart';
import '../service/reader_service.dart';
import '../viewModel/reader_detail_view_model.dart';

class ReaderDetailView extends StatelessWidget {
  final int? id;
  final BuildContext buildContext;
  const ReaderDetailView({super.key, this.id, required this.buildContext});

  @override
  Widget build(BuildContext context) {
    ReaderDetailViewModel viewModel = ReaderDetailViewModel(
        ReaderService(networkManager: NetworkManager()),
        AccessLocationService(networkManager: NetworkManager()),
        id,
        context);
    viewModel.init();
    return buildPopup(context, viewModel);
  }

  Widget buildPopup(BuildContext context, ReaderDetailViewModel viewModel) {
    return Center(
      child: Observer(builder: (_) {
        switch (viewModel.dataState) {
          case DataState.LOADING:
            return Center(child: CircularProgressIndicator());
          case DataState.ERROR:
            return Center(
                child: Text("Okuyucu Detayı görüntülenirken bir hata oluştu"));
          default:
            return SizedBox(
              width: SizeConfig.blockSizeHorizontal * 30,
              height: SizeConfig.blockSizeVertical * 33,
              child: SimpleContainer(
                padding: 0,
                title: "Okuyucu",
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: InputText2(
                                icon: Icon(Icons.qr_code_scanner),
                                hintText: "Okuyucu  Adı",
                                textEditingController:
                                    viewModel.textEditingControllerList[0])),
                        Expanded(
                            flex: 5,
                            child: InputText2(
                                icon: Icon(Icons.control_point),
                                hintText: "Okuyucu Tipi",
                                textEditingController:
                                    viewModel.textEditingControllerList[1])),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: InputText2(
                                icon: Icon(Icons.swap_horiz),
                                hintText: "Okuyucu Yönü",
                                textEditingController:
                                    viewModel.textEditingControllerList[2])),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: DropDownInputText(
                              title: "Alan",
                              textEditingController: TextEditingController(
                                  text: viewModel
                                              .readerDetail!.accessLocationId !=
                                          null
                                      ? viewModel.accessLocationList!
                                          .firstWhere((element) =>
                                              element.id ==
                                              viewModel.readerDetail!
                                                  .accessLocationId)
                                          .name
                                      : ""),
                              items: viewModel.accessLocationList!
                                  .map((e) => e.name)
                                  .toList(),
                              onTap: (index) {
                                viewModel.readerDetail!.accessLocationId =
                                    viewModel.accessLocationList![index].id;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: SizeConfig.blockSizeVertical * 4,
                            width: SizeConfig.blockSizeHorizontal * 10,
                            child: TextButton(
                                onPressed: () async {
                                  if (await viewModel.updateReader()) {
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
                            height: SizeConfig.blockSizeVertical * 4,
                            width: SizeConfig.blockSizeHorizontal * 10,
                            child: TextButton(
                                onPressed: () =>
                                    Navigator.of(buildContext).pop(),
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
      }),
    );
  }
}
