import 'package:mobx/mobx.dart';
import 'package:webapp/core/base/base_view_model.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/model/response_model.dart';
import 'package:webapp/screen/service/department_list_service.dart';

import '../model/department_list_item.dart';
part 'department_list_view_model.g.dart';

class DepartmentListViewModel = _DepartmentListViewModelBase
    with _$DepartmentListViewModel;

abstract class _DepartmentListViewModelBase extends BaseViewModel with Store {
  final DepartmentListService departmentListService;

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  List<DepartmentListItem>? departmentList;

  @observable
  List<DepartmentListItem>? filteredDepartmanList;

  @observable
  int pageState = 0;

  @observable
  int selectedEmployeeId = 0;

  _DepartmentListViewModelBase(this.departmentListService);

  @override
  @action
  Future<void> init() async {
    ResponseModel<List<DepartmentListItem>?> result =
        await departmentListService.getDepartmentList();
    if ((!result.error!) || result.data != null) {
      departmentList = result.data;
      filteredDepartmanList = departmentList;
      departmentList!.isEmpty
          ? dataState = DataState.EMPTY
          : dataState = DataState.READY;
    } else {
      dataState = DataState.ERROR;
    }
  }

  @action
  changePageState(value) {
    pageState = value;
  }

  @action
  changeSelectedEmployeeId(value) {
    selectedEmployeeId = value;
  }

  @action
  filter(name) {
    filteredDepartmanList = departmentList
        ?.where((e) => e.name!.toLowerCase().startsWith(name.toLowerCase()))
        .toList();
  }
}
