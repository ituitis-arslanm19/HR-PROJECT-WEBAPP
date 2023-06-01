import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/cache/secure_storage.dart';

import '../../core/constant/enum/enums.dart';
import '../../core/network/network_manager.dart';
import '../../core/util/size_config.dart';
import '../../core/widgets/other/input_text.dart';
import '../../core/widgets/other/input_text2.dart';
import '../../core/widgets/other/simple_container.dart';
import '../service/shift_service.dart';
import '../viewModel/shift_detail_view_model.dart';
import 'main_view.dart';

class ShiftDetailView extends StatelessWidget {
  final int? id;
  final BuildContext buildContext;
  const ShiftDetailView({super.key, this.id, required this.buildContext});

  @override
  Widget build(BuildContext context) {
    ShiftDetailViewModel viewModel = ShiftDetailViewModel(
        ShiftService(networkManager: NetworkManager(SecureStorage())),
        id,
        context);
    viewModel.init();
    return buildPopup(context, viewModel);
  }

  Widget buildPopup(BuildContext context, ShiftDetailViewModel viewModel) {
    return Center(
      child: Observer(builder: (_) {
        switch (viewModel.dataState) {
          case DataState.LOADING:
            return Center(child: CircularProgressIndicator());
          case DataState.ERROR:
            return Center(
                child: Text("Vardiya Detayı görüntülenirken bir hata oluştu"));
          default:
            return SizedBox(
              width: SizeConfig.blockSizeHorizontal * 30,
              height: SizeConfig.blockSizeVertical * 30,
              child: SimpleContainer(
                padding: 0,
                title: "Vardiya",
                child: Column(
                  children: [
                    InputText2(
                        icon: Icon(Icons.access_alarm),
                        hintText: "Vardiya  Adı",
                        textEditingController:
                            viewModel.textEditingControllerList[0]),
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: InputText2(
                                icon: Icon(Icons.access_time),
                                hintText: "Başlangıç Saati",
                                textEditingController:
                                    viewModel.textEditingControllerList[1])),
                        Expanded(
                            flex: 5,
                            child: InputText2(
                                icon: Icon(Icons.access_time),
                                hintText: "Bitiş Saati",
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
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.05,
                            child: TextButton(
                                onPressed: () async {
                                  if (await viewModel.updateShift()) {
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
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.05,
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
