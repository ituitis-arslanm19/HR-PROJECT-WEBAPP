import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../core/constant/enum/enums.dart';
import '../../core/network/network_manager.dart';
import '../../core/util/size_config.dart';
import '../../core/widgets/other/input_text2.dart';
import '../../core/widgets/other/simple_container.dart';
import '../service/site_service.dart';
import '../viewModel/site_detail_view_model.dart';

class SiteDetailView extends StatelessWidget {
  final int? id;
  final BuildContext buildContext;
  const SiteDetailView({super.key, this.id, required this.buildContext});

  @override
  Widget build(BuildContext context) {
    SiteDetailViewModel viewModel = SiteDetailViewModel(
        SiteService(networkManager: NetworkManager()), id, context);
    viewModel.init();
    return buildPopup(context, viewModel);
  }

  Widget buildPopup(BuildContext context, SiteDetailViewModel viewModel) {
    return Center(
      child: Observer(builder: (_) {
        switch (viewModel.dataState) {
          case DataState.LOADING:
            return Center(child: CircularProgressIndicator());
          case DataState.ERROR:
            return Center(
                child: Text("Alan Detayı görüntülenirken bir hata oluştu"));
          default:
            return SizedBox(
              width: SizeConfig.blockSizeHorizontal * 30,
              height: SizeConfig.blockSizeVertical * 25,
              child: SimpleContainer(
                padding: 0,
                title: "Alan",
                child: Column(
                  children: [
                    InputText2(
                        icon: Icon(
                          Icons.aspect_ratio,
                        ),
                        hintText: "Alan  Adı",
                        textEditingController:
                            viewModel.textEditingControllerList[0]),
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
                                  if (await viewModel.updateSite()) {
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
