import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:webapp/screen/service/asset_type_service.dart';
import '../../core/constant/enum/enums.dart';
import '../../core/network/network_manager.dart';
import '../../core/util/size_config.dart';
import '../../core/widgets/other/drop_down_input_text.dart';
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
    void showCalendar(BuildContext context,
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
        AssetTypeService(networkManager: NetworkManager()),
        EmployeeService(networkManager: NetworkManager()),
        context);
    viewModel.init();
    return buildPopup(context, viewModel, showCalendar);
  }

  Widget buildPopup(BuildContext context, AssetDetailViewModel viewModel,
      void Function(BuildContext, TextEditingController) showCalendar) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical * 40,
      width: SizeConfig.blockSizeHorizontal * 40,
      child: Center(
        child: Observer(builder: (_) {
          switch (viewModel.dataState) {
            case DataState.LOADING:
              return const Center(child: CircularProgressIndicator());
            case DataState.ERROR:
              return const Center(
                  child: Text("Zimmet detayı görüntülenirken bir hata oluştu"));
            default:
              return buildContent(viewModel, context, showCalendar);
          }
        }),
      ),
    );
  }

  SizedBox buildContent(AssetDetailViewModel viewModel, BuildContext context,
      void Function(BuildContext, TextEditingController) showCalendar) {
    return SizedBox(
      child: SimpleContainer(
        padding: 0,
        title: "Zimmet",
        child: viewModel.pageState
            ? buildPage2(viewModel, context)
            : buildPage1(viewModel, context, showCalendar),
      ),
    );
  }

  Column buildPage2(AssetDetailViewModel viewModel, BuildContext context) {
    return Column(
      children: [
        InputText2(
            icon: const Icon(Icons.computer),
            hintText: "Açıklama",
            textEditingController: viewModel.textEditingControllerList[0]),
        DropDownInputText(
          title: "İade Durumu",
          textEditingController: TextEditingController(),
          items: const ["İade Alındı", "İade alınmadı"],
          onTap: (index) {
            index == 0
                ? viewModel.productStatus = ProductStatus.RETURNED
                : viewModel.productStatus = ProductStatus.NOT_RETURNED;
          },
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
                      if (await viewModel.updateAssetStatus()) {
                        Navigator.pop(buildContext);
                      }
                    },
                    style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(buildContext).colorScheme.primary),
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
                    onPressed: () => Navigator.of(buildContext).pop(),
                    style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(buildContext).colorScheme.primary),
                    child: const Text("İptal",
                        style: TextStyle(color: Colors.white))),
              ),
            ),
          ],
        )
      ],
    );
  }

  Column buildPage1(AssetDetailViewModel viewModel, BuildContext context,
      void Function(BuildContext, TextEditingController) showCalendar) {
    bool enabled;
    enabled = (viewModel.assetDetail?.status == ProductStatus.AT_EMPLOYEE)
        ? true
        : false;
    Employee? employee = viewModel.employeeList!.firstWhere(
        (element) => element.id == viewModel.assetDetail!.employeeId,
        orElse: () => Employee());
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                flex: 5,
                child: InputText2(
                    enabled: enabled,
                    icon: const Icon(Icons.computer),
                    hintText: "Ürün Adı",
                    textEditingController:
                        viewModel.textEditingControllerList[0])),
            Expanded(
              flex: 5,
              child: DropDownInputText(
                enabled: enabled,
                title: "Çalışan",
                textEditingController: TextEditingController(
                    text: viewModel.assetDetail!.employeeId != null
                        ? (employee.firstName ?? "") +
                            " " +
                            (employee.lastName ?? "")
                        : ""),
                items: viewModel.employeeList!
                    .map((e) => (e.firstName ?? "") + "" + (e.lastName ?? ""))
                    .toList(),
                onTap: (index) {
                  viewModel.assetDetail!.employeeId =
                      viewModel.employeeList![index].id;
                },
              ),
            ),
          ],
        ),
        Row(children: [
          Expanded(
              flex: 5,
              child: InputText2(
                  enabled: enabled,
                  onTap: () => showCalendar(
                      buildContext, viewModel.textEditingControllerList[1]),
                  icon: const Icon(Icons.calendar_month),
                  hintText: "Veriliş Tarihi",
                  textEditingController:
                      viewModel.textEditingControllerList[1])),
          Expanded(
            flex: 5,
            child: DropDownInputText(
              enabled: enabled,
              title: "Zimmet Türü",
              textEditingController: TextEditingController(
                  text: viewModel.assetDetail!.type != null
                      ? viewModel.assetDetail!.type?.name
                      : ""),
              items: viewModel.assetTypeList!.map((e) => e.name).toList(),
              onTap: (index) {
                viewModel.assetDetail!.type = viewModel.assetTypeList![index];
              },
            ),
          )
        ]),
        InputText2(
            enabled: enabled,
            icon: const Icon(Icons.description),
            hintText: "Açıklama",
            textEditingController: viewModel.textEditingControllerList[2]),
        if (viewModel.assetDetail?.status == ProductStatus.AT_EMPLOYEE)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (id != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width * 0.05,
                    child: TextButton(
                        onPressed: () {
                          viewModel.pageState = !viewModel.pageState;
                        },
                        child: const Text("İade",
                            style: TextStyle(color: Colors.white)),
                        style: TextButton.styleFrom(
                            backgroundColor:
                                Theme.of(buildContext).colorScheme.primary)),
                  ),
                ),
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
                          backgroundColor:
                              Theme.of(buildContext).colorScheme.primary),
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
                      onPressed: () => Navigator.of(buildContext).pop(),
                      style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(buildContext).colorScheme.primary),
                      child: const Text("İptal",
                          style: TextStyle(color: Colors.white))),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
