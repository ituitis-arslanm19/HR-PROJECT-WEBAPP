import 'package:mobx/mobx.dart';
import 'package:webapp/core/base/base_view_model.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/screen/model/department_info.dart';
import 'package:webapp/screen/model/employee_info.dart';
import 'package:webapp/screen/service/department_info_service.dart';
import 'package:webapp/screen/service/employee_info_service.dart';

import '../../core/network/model/response_model.dart';
part 'department_info_view_model.g.dart';

class DepartmentInfoViewModel = _DepartmentInfoViewModelBase
    with _$DepartmentInfoViewModel;

abstract class _DepartmentInfoViewModelBase extends BaseViewModel with Store {
  final DepartmentInfoService departmentInfoService;
  final int id;

  _DepartmentInfoViewModelBase(this.departmentInfoService, this.id);

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  DepartmentInfo? departmentInfo;

  @observable
  int? pieChartIndex = -1;

  @override
  @action
  Future<void> init() async {
    ResponseModel<DepartmentInfo?> result =
        await departmentInfoService.getDepartmentInfo(id);

    if ((!result.error!) && result.data != null) {
      departmentInfo = result.data;
      dataState = DataState.READY;
    } else {
      dataState = DataState.ERROR;
    }
  }

  @action
  changePieChartIndex(int value) {
    pieChartIndex = value;
  }

  String getInitials(String name) => name.isNotEmpty
      ? name
          .trim()
          .split(' ')
          .map((l) => l != "ve" ? l[0] : "")
          .take(2)
          .join()
          .toUpperCase()
      : '';
}
