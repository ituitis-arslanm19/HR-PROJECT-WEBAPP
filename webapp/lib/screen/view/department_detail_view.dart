import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/cache/secure_storage.dart';

import '../../core/constant/enum/enums.dart';
import '../../core/network/network_manager.dart';
import '../../core/util/size_config.dart';
import '../../core/widgets/other/input_text.dart';
import '../model/employee.dart';
import '../service/department_service.dart';
import '../service/employee_service.dart';
import '../viewModel/department_detail_view_model.dart';
import 'main_view.dart';

class DepartmentDetailView extends StatelessWidget {
  final int? id;
  final BuildContext buildContext;
  const DepartmentDetailView({super.key, this.id, required this.buildContext});

  @override
  Widget build(BuildContext context) {
    DepartmentDetailViewModel viewModel = DepartmentDetailViewModel(
        DepartmentService(networkManager: NetworkManager(SecureStorage())),
        id,
        EmployeeService(networkManager: NetworkManager(SecureStorage())),
        context);
    viewModel.init();
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal * 50,
      height: SizeConfig.blockSizeVertical * 35,
      child: Scaffold(
          body: MyStatelessWidget(
        viewModel: viewModel,
        buildContext: buildContext,
      )),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  final DepartmentDetailViewModel viewModel;
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
                child:
                    Text("Departman detayı görüntülenirken bir hata oluştu"));
          default:
            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.075,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Departman",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold)),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: InputText(
                            icon: Icon(Icons.work),
                            hintText: "Departman Adı",
                            textEditingController:
                                viewModel.textEditingControllerList[0])),
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Departman Yöneticisi")),
                          DropdownButtonFormField(
                              value: viewModel.departmentDetail!.managerId,
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
                                viewModel.departmentDetail!.managerId = value;
                              }),
                        ],
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
                              child: Text("Yönetici")),
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
                                          prefixIcon: Icon(Icons.people)),
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
                                      onChanged: (value) =>
                                          viewModel.changeEmployeeId(value!)),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 4.0, bottom: 2.0),
                                    height: 50,
                                    child: TextButton(
                                        onPressed: () => viewModel
                                            .addEmployee(viewModel.employeeId!),
                                        child: Text("Ekle",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        style: TextButton.styleFrom(
                                            backgroundColor: Color.fromARGB(
                                                255, 55, 107, 251))),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(4.0),
                  height: MediaQuery.of(context).size.height * 0.032,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Text("İzin İsteğini Onaylaması Gereken Yöneticiler",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.height * 0.18,
                  child: SingleChildScrollView(
                      child: viewModel.employeeListDataState == DataState.READY
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
                              rows: viewModel
                                  .managersToSign! // Loops through dataColumnText, each iteration assigning the value to element
                                  .map(
                                    ((element) => DataRow(
                                          cells: <DataCell>[
                                            DataCell(
                                                Text(element.id!.toString())),
                                            DataCell(Text(element.firstName! +
                                                " " +
                                                element
                                                    .lastName!)), //Extracting fro
                                            DataCell(Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                    onPressed: () => viewModel
                                                        .removeEmployee(
                                                            element.id!),
                                                    icon: Icon(Icons.close))
                                              ],
                                            ))
                                          ],
                                        )),
                                  )
                                  .toList(),
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
                              if (await viewModel.updateDepartment()) {
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
