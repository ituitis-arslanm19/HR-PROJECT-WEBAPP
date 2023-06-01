import 'package:mobx/mobx.dart';
import 'package:webapp/core/base/base_view_model.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/model/response_model.dart';
import 'package:webapp/screen/service/employee_list_service.dart';
import 'package:webapp/screen/service/home_service.dart';

import '../model/dashboard/dashboard.dart';
import '../model/employee_list_item.dart';
part 'employee_list_view_model.g.dart';

class EmployeeListViewModel = _EmployeeListViewModelBase
    with _$EmployeeListViewModel;

abstract class _EmployeeListViewModelBase extends BaseViewModel with Store {
  final EmployeeListService employeeListService;

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  int pageState = 0;

  @observable
  int selectedEmployeeId = 0;

  @observable
  List<EmployeeListItem>? filteredEmployeeList;

  @observable
  List<EmployeeListItem>? employeeList;

  _EmployeeListViewModelBase(this.employeeListService);

  @override
  @action
  Future<void> init() async {
    ResponseModel<List<EmployeeListItem>?> result =
        await employeeListService.getEmployeeList();
    if ((!result.error!) || result.data != null) {
      employeeList = result.data;
      filteredEmployeeList = employeeList;
      employeeList!.isEmpty
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
    filteredEmployeeList = employeeList
        ?.where(
            (e) => e.firstName!.toLowerCase().startsWith(name.toLowerCase()))
        .toList();
  }
}
