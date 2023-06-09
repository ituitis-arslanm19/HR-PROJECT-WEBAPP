import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../core/constant/enum/enums.dart';
import '../../core/network/network_manager.dart';
import '../../core/util/size_config.dart';
import '../../core/widgets/other/drop_down_input_text.dart';
import '../../core/widgets/other/input_text2.dart';
import '../../core/widgets/other/simple_container.dart';
import '../service/department_service.dart';
import '../service/employee_service.dart';
import '../viewModel/department_detail_view_model.dart';

class DepartmentDetailView extends StatelessWidget {
  final int? id;
  final BuildContext buildContext;
  const DepartmentDetailView({super.key, this.id, required this.buildContext});

  @override
  Widget build(BuildContext context) {
    DepartmentDetailViewModel viewModel = DepartmentDetailViewModel(
        DepartmentService(networkManager: NetworkManager()),
        id,
        EmployeeService(networkManager: NetworkManager()),
        context);
    viewModel.init();
    return buildPopup(context, viewModel);
  }

  Widget buildPopup(BuildContext context, DepartmentDetailViewModel viewModel) {
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
            return SizedBox(
              width: SizeConfig.blockSizeHorizontal * 30,
              height: SizeConfig.blockSizeVertical * 63,
              child: SimpleContainer(
                padding: 0,
                title: "Departman",
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: InputText2(
                                icon: Icon(Icons.work),
                                hintText: "Departman Adı",
                                textEditingController:
                                    viewModel.textEditingControllerList[0])),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: DropDownInputText(
                              title: "Departman Yöneticisi",
                              textEditingController: TextEditingController(
                                  text: viewModel.departmentDetail!.managerId !=
                                          null
                                      ? viewModel.employeeList!
                                          .firstWhere((element) =>
                                              element.id ==
                                              viewModel
                                                  .departmentDetail!.managerId)
                                          .firstName
                                      : ""),
                              items: viewModel.employeeList!
                                  .map((e) => "${e.firstName!} ${e.lastName!}")
                                  .toList(),
                              onTap: (index) {
                                viewModel.departmentDetail!.managerId =
                                    viewModel.employeeList![index].id;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DropDownInputText(
                        title: "Üst Departman",
                        textEditingController: TextEditingController(
                            text: viewModel
                                        .departmentDetail!.parentDepartmentId !=
                                    null
                                ? viewModel.departmentList!
                                    .firstWhere((element) =>
                                        element.id ==
                                        viewModel.departmentDetail!
                                            .parentDepartmentId)
                                    .name
                                : ""),
                        items: viewModel.departmentList!
                            .map((e) => e.name!)
                            .toList(),
                        onTap: (index) {
                          viewModel.departmentDetail!.parentDepartmentId =
                              viewModel.departmentList![index].id;
                        },
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: DropDownInputText(
                                  title: "Yönetici",
                                  textEditingController:
                                      TextEditingController(text: ""),
                                  items: viewModel.employeeList!
                                      .map((e) =>
                                          "${e.firstName!} ${e.lastName!}")
                                      .toList(),
                                  onTap: (index) {
                                    viewModel.employeeId =
                                        viewModel.employeeList![index].id;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  height: 50,
                                  child: TextButton(
                                      onPressed: () => viewModel
                                          .addEmployee(viewModel.employeeId!),
                                      child: Text("Ekle",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      style: TextButton.styleFrom(
                                          backgroundColor:
                                              Theme.of(buildContext)
                                                  .colorScheme
                                                  .primary)),
                                )),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      height: SizeConfig.blockSizeVertical * 4,
                      width: SizeConfig.blockSizeHorizontal * 50,
                      child: Text(
                          "İzin İsteğini Onaylaması Gereken Yöneticiler",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      width: SizeConfig.screenWidth * 0.30,
                      height: SizeConfig.screenHeight * 0.18,
                      child: SingleChildScrollView(
                          child: viewModel.employeeListDataState ==
                                  DataState.READY
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
                                                DataCell(Text(
                                                    element.id!.toString())),
                                                DataCell(Text(element
                                                        .firstName! +
                                                    " " +
                                                    element
                                                        .lastName!)), //Extracting fro
                                                DataCell(Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () =>
                                                            viewModel
                                                                .removeEmployee(
                                                                    element
                                                                        .id!),
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
                            height: SizeConfig.blockSizeVertical * 4,
                            width: SizeConfig.blockSizeHorizontal * 10,
                            child: TextButton(
                                onPressed: () async {
                                  if (await viewModel.updateDepartment()) {
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
                            height: SizeConfig.blockSizeVertical * 4,
                            width: SizeConfig.blockSizeHorizontal * 10,
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
