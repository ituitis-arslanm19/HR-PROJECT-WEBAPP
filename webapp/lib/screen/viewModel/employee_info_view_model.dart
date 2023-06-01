import 'package:mobx/mobx.dart';
import 'package:webapp/core/base/base_view_model.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/screen/model/employee_info.dart';
import 'package:webapp/screen/service/employee_info_service.dart';

import '../../core/network/model/response_model.dart';
part 'employee_info_view_model.g.dart';

class EmployeeInfoViewModel = _EmployeeInfoViewModelBase
    with _$EmployeeInfoViewModel;

abstract class _EmployeeInfoViewModelBase extends BaseViewModel with Store {
  final EmployeeInfoService employeeInfoService;
  final int id;

  _EmployeeInfoViewModelBase(this.employeeInfoService, this.id);

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  EmployeeInfo? employeeInfo;

  @override
  @action
  Future<void> init() async {
    ResponseModel<EmployeeInfo?> result =
        await employeeInfoService.getEmployeeInfo(id);

    if ((!result.error!) && result.data != null) {
      employeeInfo = result.data;

      dataState = DataState.READY;
    } else {
      dataState = DataState.ERROR;
    }
  }
}
