import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/core/widgets/other/list_card.dart';
import 'package:webapp/core/widgets/other/search_field.dart';
import 'package:webapp/screen/service/employee_list_service.dart';
import 'package:webapp/screen/viewModel/employee_list_view_model.dart';

import '../../core/constant/enum/enums.dart';
import '../model/employee_list_item.dart';
import 'employee_info_view.dart';

class EmployeeListView extends StatelessWidget {
  final ClientType clientType;
  const EmployeeListView({super.key, required this.clientType});

  @override
  Widget build(BuildContext context) {
    EmployeeListViewModel employeeListViewModel = EmployeeListViewModel(
        EmployeeListService(NetworkManager(), clientType));
    employeeListViewModel.init();
    return Observer(builder: (_) {
      switch (employeeListViewModel.pageState) {
        case 1:
          return buildPageState1(employeeListViewModel);
        default:
          return buildPageState0(employeeListViewModel, context);
      }
    });
  }

  Row buildPageState1(EmployeeListViewModel employeeListViewModel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 8),
          child: Container(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () {
                        employeeListViewModel.changePageState(0);
                      },
                      child: Icon(Icons.arrow_back)))),
        ),
        Expanded(
            child:
                EmployeeInfoView(id: employeeListViewModel.selectedEmployeeId)),
      ],
    );
  }

  Padding buildPageState0(
      EmployeeListViewModel employeeListViewModel, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.blockSizeHorizontal * 3.5,
        right: SizeConfig.blockSizeHorizontal * 3.5,
      ),
      child: Column(children: [
        Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 3,
                right: SizeConfig.blockSizeHorizontal * 3,
                top: SizeConfig.blockSizeHorizontal * 1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SearchField(
                    textEditingController: TextEditingController(),
                    onChanged: (text) {
                      employeeListViewModel.filter(text);
                    },
                  ),
                ],
              ),
            )),
        Expanded(
          flex: 19,
          child: Observer(builder: (_) {
            switch (employeeListViewModel.dataState) {
              case DataState.READY:
                return buildEmployeeList(context, employeeListViewModel);
              case DataState.ERROR:
                return const Center(child: Text("Hata meydana geldi."));
              case DataState.LOADING:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case DataState.EMPTY:
                return const Center(
                    child: Text("Kayıtılı çalışan bulunmamakta"));
            }
          }),
        ),
      ]),
    );
  }

  ListView buildEmployeeList(
      BuildContext buildContext, EmployeeListViewModel employeeListViewModel) {
    List<EmployeeListItem> employeeList =
        employeeListViewModel.filteredEmployeeList!;
    return ListView.builder(
        itemCount: employeeList.length ~/ 3 + 1,
        itemBuilder: ((context, index) {
          return Row(
            children: [
              ...index * 3 + 3 < employeeList.length
                  ? employeeList
                      .sublist(index * 3, index * 3 + 3)
                      .map((e) => Padding(
                            padding: EdgeInsets.all(
                              SizeConfig.blockSizeHorizontal * 3,
                            ),
                            child: ListCard(
                                onTap: () {
                                  employeeListViewModel
                                      .changeSelectedEmployeeId(e.id);
                                  employeeListViewModel.changePageState(1);
                                },
                                name: (e.firstName ?? "Hata") +
                                    " " +
                                    (e.lastName ?? ""),
                                secondTxt: e.departmentName,
                                thirdTxt: e.email),
                          ))
                  : employeeList
                      .sublist(index * 3, employeeList.length)
                      .map((e) => Padding(
                            padding: EdgeInsets.all(
                              SizeConfig.blockSizeHorizontal * 3,
                            ),
                            child: ListCard(
                                onTap: () {
                                  employeeListViewModel
                                      .changeSelectedEmployeeId(e.id);
                                  employeeListViewModel.changePageState(1);
                                },
                                name: (e.firstName ?? "Hata") +
                                    " " +
                                    (e.lastName ?? ""),
                                secondTxt: e.departmentName,
                                thirdTxt: e.email),
                          ))
            ],
          );
        }));
  }
}
