import 'package:mobx/mobx.dart';

import '../../core/constant/enum/enums.dart';
import '../model/employee.dart';
import '../service/employee_service.dart';
part 'employee_view_model.g.dart';

class EmployeeViewModel = _EmployeeViewModelBase with _$EmployeeViewModel;

abstract class _EmployeeViewModelBase with Store {
  final EmployeeService employeeService;
  final ClientType clientType;

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  List<Employee>? employeeList;

  @observable
  List<Employee>? employees;

  _EmployeeViewModelBase(this.employeeService, this.clientType);

  @action
  init() async {
    employees = clientType == ClientType.HR
        ? await employeeService.getEmployees()
        : await employeeService.getEmployeesbyDepartment();
    employeeList = employees;
    if (employeeList != null && employeeList!.isNotEmpty) {
      dataState = DataState.READY;
    } else {
      dataState = DataState.ERROR;
    }
  }

  @action
  filter(email) {
    employeeList = employees
        ?.where((employee) =>
            employee.email!.toLowerCase().startsWith(email.toLowerCase()))
        .toList();
  }

  @action
  delete(int id) async {
    return await employeeService.delete(id);
  }
}
