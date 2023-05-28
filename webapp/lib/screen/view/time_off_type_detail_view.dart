import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import '../../core/constant/enum/enums.dart';
import '../../core/network/network_manager.dart';
import '../../core/util/size_config.dart';
import '../../core/widgets/other/input_text.dart';
import '../../core/widgets/other/input_text2.dart';
import '../../core/widgets/other/simple_container.dart';
import '../service/time_off_type_service.dart';
import '../viewModel/employee_detail_view_model.dart';
import '../viewModel/time_off_type_detail_view_model.dart';

class TimeOffTypeDetailView extends StatelessWidget {
  final int? id;
  final BuildContext buildContext;
  const TimeOffTypeDetailView({super.key, this.id, required this.buildContext});

  @override
  Widget build(BuildContext context) {
    TimeOffTypeDetailViewModel viewModel = TimeOffTypeDetailViewModel(
        TimeOffTypeService(networkManager: NetworkManager(SecureStorage())),
        id,
        context);
    viewModel.init();
    return buildPopup(context, viewModel);
  }

  Widget buildPopup(BuildContext context, TimeOffTypeDetailViewModel viewModel) {
    return Center(
      child: Observer(builder: (_) {
        switch (viewModel.dataState) {
          case DataState.LOADING:
            return Center(child: CircularProgressIndicator());
          case DataState.ERROR:
            return Center(
                child:
                    Text("İzin tipi detayı görüntülenirken bir hata oluştu"));
          default:
            return SizedBox(
              width: SizeConfig.blockSizeHorizontal * 50,
              height: SizeConfig.blockSizeVertical * 35,
              child: SimpleContainer(
                padding: 0,
                title: "İzin Tipi",
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: InputText2(
                                icon: Icon(Icons.tour),
                                hintText: "İzin Tipi Adı",
                                textEditingController:
                                    viewModel.textEditingControllerList[0])),
                        Expanded(
                            flex: 5,
                            child: InputText2(
                                icon: Icon(Icons.description),
                                hintText: "İzin Tipi Açıklaması",
                                textEditingController:
                                    viewModel.textEditingControllerList[1])),
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
                                  if (await viewModel.updateTimeOffType()) {
                                    Navigator.pop(buildContext);
                                  }
                                },
                                child: Text("Kaydet",
                                    style: TextStyle(color: Colors.white)),
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 55, 107, 251))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.05,
                            child: TextButton(
                                onPressed: () => Navigator.of(buildContext).pop(),
                                child: Text("İptal",
                                    style: TextStyle(color: Colors.white)),
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 55, 107, 251))),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
        }
      }),
    );
  }
}
