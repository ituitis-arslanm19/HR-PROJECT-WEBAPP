import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/cache/secure_storage.dart';

import '../../core/constant/enum/enums.dart';
import '../../core/network/network_manager.dart';
import '../../core/widgets/other/input_text.dart';
import '../service/site_service.dart';
import '../viewModel/site_detail_view_model.dart';
import 'main_view.dart';

class SiteDetailView extends StatelessWidget {
  final int? id;
  final BuildContext buildContext;
  const SiteDetailView({super.key, this.id, required this.buildContext});

  static const String _title = 'Alan Detay Pop-up';

  @override
  Widget build(BuildContext context) {
    SiteDetailViewModel viewModel = SiteDetailViewModel(
        SiteService(networkManager: NetworkManager(SecureStorage())),
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
  final SiteDetailViewModel viewModel;
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
                child: Text("Alan Detayı görüntülenirken bir hata oluştu"));
          default:
            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.075,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Alan",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold)),
                  ),
                ),
                InputText(
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
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.05,
                        child: TextButton(
                            onPressed: () async {
                              if (await viewModel.updateSite()) {
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
