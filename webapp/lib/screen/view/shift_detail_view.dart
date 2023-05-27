import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/cache/secure_storage.dart';

import '../../core/constant/enum/enums.dart';
import '../../core/network/network_manager.dart';
import '../../core/widgets/other/input_text.dart';
import '../service/shift_service.dart';
import '../viewModel/shift_detail_view_model.dart';
import 'main_view.dart';

class ShiftDetailView extends StatelessWidget {
  final int? id;
  final BuildContext buildContext;
  const ShiftDetailView({super.key, this.id, required this.buildContext});

  static const String _title = 'Vardiya Detayı';

  @override
  Widget build(BuildContext context) {
    ShiftDetailViewModel viewModel = ShiftDetailViewModel(
        ShiftService(networkManager: NetworkManager(SecureStorage())),
        id,
        context);
    viewModel.init();
    return MaterialApp(
      title: _title,
      home: Scaffold(
          body: MyStatelessWidget(
        viewModel: viewModel,
        buildContext: buildContext,
      )),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  final ShiftDetailViewModel viewModel;
  final BuildContext buildContext;
  const MyStatelessWidget(
      {super.key, required this.viewModel, required this.buildContext});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Observer(builder: (_) {
        switch (viewModel.dataState) {
          case DataState.LOADING:
            return Center(child: CircularProgressIndicator());
          case DataState.ERROR:
            return Center(
                child: Text("Vardiya Detayı görüntülenirken bir hata oluştu"));
          default:
            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.075,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Vardiya",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold)),
                  ),
                ),
                InputText(
                    icon: Icon(Icons.access_alarm),
                    hintText: "Vardiya  Adı",
                    textEditingController:
                        viewModel.textEditingControllerList[0]),
                Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: InputText(
                            icon: Icon(Icons.access_time),
                            hintText: "Başlangıç Saati",
                            textEditingController:
                                viewModel.textEditingControllerList[1])),
                    Expanded(
                        flex: 5,
                        child: InputText(
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
            );
        }
      }),
    );
  }
}
