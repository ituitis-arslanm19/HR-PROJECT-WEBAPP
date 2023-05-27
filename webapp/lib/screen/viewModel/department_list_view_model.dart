import 'package:mobx/mobx.dart';
import 'package:webapp/core/base/base_view_model.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/model/response_model.dart';
import 'package:webapp/screen/service/department_list_service.dart';
import 'package:webapp/screen/service/employee_list_service.dart';
import 'package:webapp/screen/service/home_service.dart';

import '../model/dashboard/dashboard.dart';
import '../model/department_list_item.dart';
import '../model/employee_list_item.dart';
part 'department_list_view_model.g.dart';

class DepartmentListViewModel = _DepartmentListViewModelBase
    with _$DepartmentListViewModel;

abstract class _DepartmentListViewModelBase extends BaseViewModel with Store {
  final DepartmentListService departmentListService;

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  List<DepartmentListItem>? departmentList;

  _DepartmentListViewModelBase(this.departmentListService);

  @override
  @action
  Future<void> init() async {
    ResponseModel<List<DepartmentListItem>?> result =
        await departmentListService.getDepartmentList();
    if ((!result.error!) || result.data != null) {
      departmentList = result.data;
      departmentList!.isEmpty
          ? dataState = DataState.EMPTY
          : dataState = DataState.READY;
    } else {
      dataState = DataState.ERROR;
    }
  }
}
