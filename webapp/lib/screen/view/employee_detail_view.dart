import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/widgets/other/simple_container.dart';
import '../../core/constant/enum/enums.dart';

import '../../core/network/network_manager.dart';
import '../../core/util/size_config.dart';
import '../../core/widgets/other/input_text.dart';
import '../../core/widgets/other/input_text2.dart';
import '../model/department.dart';
import '../model/shift.dart';
import '../model/site.dart';
import '../service/department_service.dart';
import '../service/employee_service.dart';
import '../service/shift_service.dart';
import '../service/site_service.dart';
import '../viewModel/employee_detail_view_model.dart';
import 'main_view.dart';

class EmployeeDetailView extends StatelessWidget {
  final int? id;
  final BuildContext buildContext;
  EmployeeDetailView({super.key, required this.id, required this.buildContext});

  void _showCalendar(
      BuildContext context, TextEditingController textEditingController) async {
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

  @override
  Widget build(BuildContext context) {
    EmployeeDetailViewModel viewModel = EmployeeDetailViewModel(
      EmployeeService(networkManager: NetworkManager(SecureStorage())),
      id,
      DepartmentService(networkManager: NetworkManager(SecureStorage())),
      SiteService(networkManager: NetworkManager(SecureStorage())),
      context,
      ShiftService(networkManager: NetworkManager(SecureStorage())),
    );
    viewModel.init();
    return buildPopUp(context, viewModel, _showCalendar);
  }

  Widget buildPopUp(BuildContext context, EmployeeDetailViewModel viewModel,
      void Function(BuildContext, TextEditingController) showCalendar) {
    return Center(
      child: Observer(builder: (_) {
        switch (viewModel.dataState) {
          case DataState.LOADING:
            return Center(child: CircularProgressIndicator());
          case DataState.ERROR:
            return Center(
                child: Text("Çalışanlar görüntülenirken bir hata oluştu"));
          default:
            return SizedBox(
              width: SizeConfig.blockSizeHorizontal * 50,
              height: SizeConfig.blockSizeVertical * 80,
              child: SimpleContainer(
                title: "Çalışan",
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: InputText2(
                                icon: Icon(Icons.person),
                                hintText: "Ad",
                                textEditingController:
                                    viewModel.textEditingControllerList[0])),
                        Expanded(
                            flex: 5,
                            child: InputText2(
                                icon: Icon(Icons.person),
                                hintText: "Soyad",
                                textEditingController:
                                    viewModel.textEditingControllerList[1])),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: InputText2(
                                icon: Icon(Icons.mail),
                                hintText: "Email",
                                textEditingController:
                                    viewModel.textEditingControllerList[2])),
                        Expanded(
                            flex: 5,
                            child: InputText2(
                                icon: Icon(Icons.credit_card),
                                hintText: "Kimlik Numarası",
                                textEditingController:
                                    viewModel.textEditingControllerList[3])),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: InputText2(
                                onTap: () => showCalendar!(buildContext,
                                    viewModel.textEditingControllerList[4]),
                                icon: Icon(Icons.date_range),
                                hintText: "Doğum Tarihi",
                                textEditingController:
                                    viewModel.textEditingControllerList[4])),
                        Expanded(
                            flex: 5,
                            child: InputText2(
                                onTap: () => showCalendar!(buildContext,
                                    viewModel.textEditingControllerList[5]),
                                icon: Icon(Icons.date_range),
                                hintText: "Başlangıç Tarihi",
                                textEditingController:
                                    viewModel.textEditingControllerList[5])),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Departman")),
                                DropdownButtonFormField(
                                    value:
                                        viewModel.employeeDetail!.departmentId,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.grey)),
                                        iconColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        prefixIcon: Icon(Icons.work)),
                                    isExpanded: true,
                                    items: viewModel.departmentList!
                                        .map((Department items) {
                                      return DropdownMenuItem(
                                        value: items.id,
                                        child: Text(items.name!),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      viewModel.employeeDetail!.departmentId =
                                          value;
                                    }),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Vardiya")),
                                DropdownButtonFormField(
                                    value: viewModel.employeeDetail!.shiftId,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.grey)),
                                        iconColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        prefixIcon: Icon(Icons.access_alarm)),
                                    isExpanded: true,
                                    items:
                                        viewModel.shiftList!.map((Shift items) {
                                      return DropdownMenuItem(
                                        value: items.id,
                                        child: Text(items.name!),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      viewModel.employeeDetail!.shiftId = value;
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Pozisyon")),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: RadioListTile(
                                        title: Text("Yönetici"),
                                        value: true,
                                        groupValue:
                                            viewModel.isManagerObservable,
                                        onChanged: (value) =>
                                            viewModel.changeIsManager(value!)),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: RadioListTile(
                                        title: Text("Çalışan"),
                                        value: false,
                                        groupValue:
                                            viewModel.isManagerObservable,
                                        onChanged: (value) =>
                                            viewModel.changeIsManager(value!)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: InputText2(
                                icon: Icon(Icons.calendar_month),
                                hintText: "Kalan İzin Günleri",
                                textEditingController:
                                    viewModel.textEditingControllerList[6])),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Cinsiyet")),
                                DropdownButtonFormField(
                                    value: viewModel.employeeDetail!.gender,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.grey)),
                                        iconColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        prefixIcon: Icon(Icons.people)),
                                    isExpanded: true,
                                    items: const <DropdownMenuItem<String>>[
                                      DropdownMenuItem(
                                        value: "MALE",
                                        child: Text("Erkek"),
                                      ),
                                      DropdownMenuItem(
                                        value: "FEMALE",
                                        child: Text("Kız"),
                                      )
                                    ],
                                    onChanged: (value) {
                                      viewModel.employeeDetail!.gender = value;
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("İzinli Olduğu Alan")),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Container(
                                      height: 50,
                                      child: DropdownButtonFormField(
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: Colors.grey)),
                                              iconColor: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              prefixIcon:
                                                  Icon(Icons.aspect_ratio)),
                                          isExpanded: true,
                                          items: viewModel.siteList!
                                              .map((Site items) {
                                            return DropdownMenuItem(
                                              value: items.id,
                                              child: Text(items.name!),
                                            );
                                          }).toList(),
                                          onChanged: (value) =>
                                              viewModel.changeSiteId(value!)),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 4.0, bottom: 2.0),
                                        height: 50,
                                        child: TextButton(
                                            onPressed: () => viewModel
                                                .addSite(viewModel.siteId!),
                                            child: Text("Ekle",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            style: TextButton.styleFrom(
                                                backgroundColor: Color.fromARGB(
                                                    255, 55, 107, 251))),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.22,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: SingleChildScrollView(
                          child: viewModel.siteListDataState == DataState.READY
                              ? DataTable(
                                  columns: const <DataColumn>[
                                    DataColumn(
                                      label: Expanded(
                                        child: Text(
                                          'Id',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text(
                                          'Ad',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text(
                                          '',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: viewModel.employeeDetail!.siteList !=
                                          null
                                      ? viewModel.employeeDetail!
                                          .siteList! // Loops through dataColumnText, each iteration assigning the value to element
                                          .map(
                                            ((element) => DataRow(
                                                  cells: <DataCell>[
                                                    DataCell(Text(element.id!
                                                        .toString())),
                                                    DataCell(Text(element
                                                        .name!)), //Extracting fro
                                                    DataCell(Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        IconButton(
                                                            onPressed: () =>
                                                                viewModel
                                                                    .removeSite(
                                                                        element
                                                                            .id!),
                                                            icon: Icon(
                                                                Icons.close))
                                                      ],
                                                    ))
                                                  ],
                                                )),
                                          )
                                          .toList()
                                      : [],
                                )
                              : Center(child: CircularProgressIndicator())),
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
                                  if (await viewModel.updateEmployee()) {
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
                                onPressed: () =>
                                    Navigator.of(buildContext).pop(),
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
