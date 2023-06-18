import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/core/widgets/other/list_card.dart';
import 'package:webapp/core/widgets/other/search_field.dart';
import 'package:webapp/screen/service/department_list_service.dart';
import 'package:webapp/screen/view/department_info_view.dart';
import 'package:webapp/screen/viewModel/department_list_view_model.dart';

import '../../core/cache/secure_storage.dart';
import '../../core/constant/enum/enums.dart';
import '../../core/network/network_manager.dart';
import '../model/department.dart';
import '../model/department_list_item.dart';

class DepartmentListView extends StatelessWidget {
  const DepartmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    DepartmentListViewModel departmentListViewModel =
        DepartmentListViewModel(DepartmentListService(NetworkManager()));
    departmentListViewModel.init();
    return Observer(builder: (_) {
      switch (departmentListViewModel.pageState) {
        case 1:
          return buildPageState1(departmentListViewModel);
        default:
          return buildPageState0(departmentListViewModel);
      }
    });
  }

  Padding buildPageState0(DepartmentListViewModel departmentListViewModel) {
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
                      departmentListViewModel.filter(text);
                    },
                  ),
                ],
              ),
            )),
        Expanded(
            flex: 19,
            child: Observer(builder: (_) {
              switch (departmentListViewModel.dataState) {
                case DataState.READY:
                  return buildDepartmentList(departmentListViewModel);
                case DataState.ERROR:
                  return const Center(child: Text("Hata meydana geldi."));
                case DataState.LOADING:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case DataState.EMPTY:
                  return const Center(
                      child: Text("Kayıtılı departman bulunmamakta"));
              }
            })),
      ]),
    );
  }

  ListView buildDepartmentList(
      DepartmentListViewModel departmentListViewModel) {
    List<DepartmentListItem> departmentList =
        departmentListViewModel.filteredDepartmanList!;
    return ListView.builder(
        itemCount: departmentList.length ~/ 3 + 1,
        itemBuilder: ((context, index) {
          return Row(
            children: [
              ...index * 3 + 3 < departmentList.length
                  ? departmentList.sublist(index * 3, index * 3 + 3).map((e) =>
                      Padding(
                        padding: EdgeInsets.all(
                          SizeConfig.blockSizeHorizontal * 3,
                        ),
                        child: ListCard(
                            onTap: () {
                              departmentListViewModel
                                  .changeSelectedEmployeeId(e.id);
                              departmentListViewModel.changePageState(1);
                            },
                            name: e.name,
                            secondTxt: e.managerName,
                            thirdTxt: e.employeeNum.toString() + " Çalışan"),
                      ))
                  : departmentList
                      .sublist(index * 3, departmentList.length)
                      .map((e) => Padding(
                            padding: EdgeInsets.all(
                              SizeConfig.blockSizeHorizontal * 3,
                            ),
                            child: ListCard(
                                onTap: () {
                                  departmentListViewModel
                                      .changeSelectedEmployeeId(e.id);
                                  departmentListViewModel.changePageState(1);
                                },
                                name: e.name,
                                secondTxt: e.managerName,
                                thirdTxt:
                                    e.employeeNum.toString() + " Çalışan"),
                          ))
            ],
          );
        }));
  }

  Row buildPageState1(DepartmentListViewModel departmentListViewModel) {
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
                        departmentListViewModel.changePageState(0);
                      },
                      child: Icon(Icons.arrow_back)))),
        ),
        Expanded(
            child: DepartmentInfoView(
                id: departmentListViewModel.selectedEmployeeId)),
      ],
    );
  }
}
