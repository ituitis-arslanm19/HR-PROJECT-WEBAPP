import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/core/widgets/other/list_card.dart';
import 'package:webapp/core/widgets/other/search_field.dart';
import 'package:webapp/screen/service/department_list_service.dart';
import 'package:webapp/screen/viewModel/department_list_view_model.dart';

import '../../core/cache/secure_storage.dart';
import '../../core/constant/enum/enums.dart';
import '../../core/network/network_manager.dart';
import '../model/department.dart';

class DepartmentListView extends StatelessWidget {
  DepartmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    DepartmentListViewModel departmentListViewModel = DepartmentListViewModel(
        DepartmentListService(NetworkManager(SecureStorage())));
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.blockSizeHorizontal * 10.5,
        right: SizeConfig.blockSizeHorizontal * 10.5,
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
                    onChanged: (text) {},
                  ),
                ],
              ),
            )),
        Expanded(
            flex: 19,
            child: Observer(builder: (_) {
              switch (departmentListViewModel.dataState) {
                case DataState.READY:
                  return buildDepartmentList(
                      departmentListViewModel.departmentList!);
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
            })),
      ]),
    );
  }

  ListView buildDepartmentList(List<Department> departmentList) {
    return ListView.builder(
        itemCount: departmentList.length ~/ 3 + 1,
        itemBuilder: ((context, index) {
          return Container(
            child: Row(
              children: [
                ...index * 3 + 3 < departmentList.length
                    ? departmentList
                        .sublist(index * 3, index * 3 + 3)
                        .map((e) => Padding(
                              padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 3,
                              ),
                              child: ListCard(
                                  onTap: () {},
                                  name: e.name,
                                  secondTxt: e.managerName,
                                  thirdTxt:
                                      e.employeeNum.toString() + "Çalışan"),
                            ))
                    : departmentList
                        .sublist(index * 3, departmentList.length)
                        .map((e) => Padding(
                              padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 3,
                              ),
                              child: ListCard(
                                  onTap: () {},
                                  name: e.name,
                                  secondTxt: e.managerName,
                                  thirdTxt:
                                      e.employeeNum.toString() + "Çalışan"),
                            ))
              ],
            ),
          );
        }));
  }
}
