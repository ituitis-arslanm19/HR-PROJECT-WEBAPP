import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import '../../core/constant/enum/enums.dart';
import '../../core/network/network_manager.dart';
import '../../core/util/size_config.dart';
import '../../core/widgets/other/input_text2.dart';
import '../../core/widgets/other/simple_container.dart';
import '../model/employee.dart';
import '../service/asset_service.dart';
import '../service/employee_service.dart';
import '../viewModel/asset_detail_view_model.dart';

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
        AssetService(networkManager: NetworkManager()),
        id,
        EmployeeService(networkManager: NetworkManager()),
        context);
    viewModel.init();
    return buildPopup(context, viewModel, _showCalendar);
  }

  Widget buildPopup(BuildContext context, AssetDetailViewModel viewModel,
      void Function(BuildContext, TextEditingController) showCalendar) {
    return Center(
      child: Observer(builder: (_) {
        switch (viewModel.dataState) {
          case DataState.LOADING:
            return const Center(child: CircularProgressIndicator());
          case DataState.ERROR:
            return const Center(
                child: Text("Ürün detayı görüntülenirken bir hata oluştu"));
          default:
            return SizedBox(
              width: SizeConfig.blockSizeHorizontal * 30,
              height: SizeConfig.blockSizeVertical * 40,
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
                                icon: const Icon(Icons.computer),
                                hintText: "Ürün Adı",
                                textEditingController:
                                    viewModel.textEditingControllerList[0])),
                        Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Çalışan")),
                              DropdownButtonFormField(
                                  value: viewModel.assetDetail!.employeeId,
                                  decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                      iconColor:
                                          Theme.of(context).colorScheme.primary,
                                      prefixIcon: const Icon(Icons.person)),
                                  isExpanded: true,
                                  items: viewModel.employeeList!
                                      .map((Employee items) {
                                    return DropdownMenuItem(
                                      value: items.id,
                                      child: Text(items.firstName! +
                                          " " +
                                          items.lastName!),
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
                              onTap: () => showCalendar(buildContext,
                                  viewModel.textEditingControllerList[1]),
                              icon: const Icon(Icons.calendar_month),
                              hintText: "Veriliş Tarihi",
                              textEditingController:
                                  viewModel.textEditingControllerList[1])),
                      Expanded(
                          flex: 5,
                          child: InputText2(
                              icon: const Icon(Icons.description),
                              hintText: "Açıklama",
                              textEditingController:
                                  viewModel.textEditingControllerList[2]))
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Zimmet Türü")),
                          DropdownButtonFormField(
                              value: viewModel.assetDetail!.type,
                              decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.grey)),
                                  iconColor:
                                      Theme.of(context).colorScheme.primary,
                                  prefixIcon: const Icon(Icons.laptop)),
                              isExpanded: true,
                              items: viewModel.productType!.map((String item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (value) {
                                viewModel.assetDetail!.type = value;
                              }),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.05,
                            child: TextButton(
                                onPressed: () async {
                                  if (await viewModel.updateAsset()) {
                                    Navigator.pop(buildContext);
                                  }
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: Theme.of(buildContext)
                                        .colorScheme
                                        .primary),
                                child: const Text("Kaydet",
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.05,
                            child: TextButton(
                                onPressed: () =>
                                    Navigator.of(buildContext).pop(),
                                style: TextButton.styleFrom(
                                    backgroundColor: Theme.of(buildContext)
                                        .colorScheme
                                        .primary),
                                child: const Text("İptal",
                                    style: TextStyle(color: Colors.white))),
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
