import 'package:mobx/mobx.dart';

import '../../core/constant/enum/enums.dart';
import '../model/department.dart';
import '../service/department_service.dart';
part 'department_view_model.g.dart';

class DepartmentViewModel = _DepartmentViewModelBase with _$DepartmentViewModel;

abstract class _DepartmentViewModelBase with Store {
  final DepartmentService departmentService;

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  List<Department>? departmentList;

  @observable
  List<Department>? departments;

  _DepartmentViewModelBase(this.departmentService);

  @action
  init() async {
    departments = await departmentService.getDepartments();
    departmentList = departments;
    if (departmentList != null) {
      dataState = DataState.READY;
    } else {
      dataState = DataState.ERROR;
    }
  }

  @action
  filter(name) {
    departmentList = departments
        ?.where((department) =>
            department.name!.toLowerCase().startsWith(name.toLowerCase()))
        .toList();
  }

  @action
  delete(int id){
    departmentService.deleteDepartment(id);
  }
}
