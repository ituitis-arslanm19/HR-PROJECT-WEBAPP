import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:webapp/core/cache/secure_storage.dart';

import '../../core/constant/enum/enums.dart';
import '../../core/network/network_manager.dart';
import '../../core/util/size_config.dart';
import '../../core/widgets/other/input_text.dart';
import '../../core/widgets/other/input_text2.dart';
import '../../core/widgets/other/simple_container.dart';
import '../model/employee.dart';
import '../service/asset_service.dart';
import '../service/employee_service.dart';
import '../viewModel/asset_detail_view_model.dart';
import 'main_view.dart';

class AssetDetailView extends StatelessWidget {
  final int? id;
  final BuildContext buildContext;
  const AssetDetailView({super.key, this.id, required this.buildContext});

  @override
  Widget build(BuildContext context) {
    void _showCalendar(BuildContext context,
        TextEditingController textEditingController) async {
      DateTime? pickedDate = await showDatePicker(
          context: context,
          locale: const Locale('tr'),
          initialDate: DateTime.now(),
          firstDate: DateTime(
              2000), //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime(2101),
          confirmText: "TAMAM");

      if (pickedDate != null) {
        String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
        textEditingController.text = formattedDate;
      }
    }

    AssetDetailViewModel viewModel = AssetDetailViewModel(
        AssetService(networkManager: NetworkManager(SecureStorage())),
        id,
        EmployeeService(networkManager: NetworkManager(SecureStorage())),
        context);
    viewModel.init();
    return buildPopup(context, viewModel, _showCalendar);
  }

  Widget buildPopup(BuildContext context, AssetDetailViewModel viewModel, void Function(BuildContext, TextEditingController) showCalendar) {
    return Center(
      child: Observer(builder: (_) {
        switch (viewModel.dataState) {
          case DataState.LOADING:
            return Center(child: CircularProgressIndicator());
          case DataState.ERROR:
            return Center(
                child: Text("Ürün detayı görüntülenirken bir hata oluştu"));
          default:
            return SizedBox(
              width: SizeConfig.blockSizeHorizontal * 50,
              height: SizeConfig.blockSizeVertical * 35,
              child: SimpleContainer(
                padding: 0,
                title: "Zimmet",
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: InputText2(
                                icon: Icon(Icons.computer),
                                hintText: "Ürün Adı",
                                textEditingController:
                                    viewModel.textEditingControllerList[0])),
                        Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Çalışan")),
                              DropdownButtonFormField(
                                  value: viewModel.assetDetail!.employeeId,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                      iconColor:
                                          Theme.of(context).colorScheme.primary,
                                      prefixIcon: Icon(Icons.person)),
                                  isExpanded: true,
                                  items:
                                      viewModel.employeeList!.map((Employee items) {
                                    return DropdownMenuItem(
                                      value: items.id,
                                      child: Text(
                                          items.firstName! + " " + items.lastName!),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    viewModel.assetDetail!.employeeId = value;
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(children: [
                      Expanded(
                          flex: 5,
                          child: InputText2(
                              onTap: () => showCalendar!(buildContext,
                                  viewModel.textEditingControllerList[1]),
                              icon: Icon(Icons.calendar_month),
                              hintText: "Veriliş Tarihi",
                              textEditingController:
                                  viewModel.textEditingControllerList[1])),
                      Expanded(
                          flex: 5,
                          child: InputText2(
                              icon: Icon(Icons.description),
                              hintText: "Açıklama",
                              textEditingController:
                                  viewModel.textEditingControllerList[2]))
                    ]),
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
                                  if (await viewModel.updateAsset()) {
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
