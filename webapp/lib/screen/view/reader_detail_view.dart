import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../core/cache/secure_storage.dart';
import '../../core/constant/enum/enums.dart';
import '../../core/network/network_manager.dart';
import '../../core/widgets/other/input_text.dart';
import '../model/access_location.dart';
import '../service/access_location_service.dart';
import '../service/reader_service.dart';
import '../viewModel/reader_detail_view_model.dart';
import 'main_view.dart';

class ReaderDetailView extends StatelessWidget {
  final int? id;
  final BuildContext buildContext;
  const ReaderDetailView({super.key, this.id, required this.buildContext});

  static const String _title = 'Okuyucu Detay Pop-up';

  @override
  Widget build(BuildContext context) {
    ReaderDetailViewModel viewModel = ReaderDetailViewModel(
        ReaderService(networkManager: NetworkManager(SecureStorage())),
        AccessLocationService(networkManager: NetworkManager(SecureStorage())),
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
  final ReaderDetailViewModel viewModel;
  final BuildContext buildContext;
  MyStatelessWidget(
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
                child: Text("Okuyucu Detayı görüntülenirken bir hata oluştu"));
          default:
            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.075,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Okuyucu",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold)),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: InputText(
                            icon: Icon(Icons.qr_code_scanner),
                            hintText: "Okuyucu  Adı",
                            textEditingController:
                                viewModel.textEditingControllerList[0])),
                    Expanded(
                        flex: 5,
                        child: InputText(
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
                        child: InputText(
                            icon: Icon(Icons.swap_horiz),
                            hintText: "Okuyucu Yönü",
                            textEditingController:
                                viewModel.textEditingControllerList[2])),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Giriş Noktası")),
                            DropdownButtonFormField(
                                value: viewModel.readerDetail!.accessLocationId,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey)),
                                    iconColor:
                                        Theme.of(context).colorScheme.primary,
                                    prefixIcon: Icon(Icons.room)),
                                isExpanded: true,
                                items: viewModel.accessLocationList!
                                    .map((AccessLocation items) {
                                  return DropdownMenuItem(
                                    value: items.id,
                                    child: Text(items.name!),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  viewModel.readerDetail!.accessLocationId =
                                      value;
                                }),
                          ],
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
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.05,
                        child: TextButton(
                            onPressed: () async {
                              if (await viewModel.updateReader()) {
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
