import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/screen/model/dashboard/dashboard.dart';
import 'package:webapp/screen/model/employee.dart';

import '../../core/constant/enum/enums.dart';
import '../../core/network/model/response_model.dart';

class EmployeeListService {
  final NetworkManager networkManager;

  EmployeeListService(this.networkManager);

  Future<ResponseModel<List<Employee>?>> getEmployeeList() async {
    ResponseModel<List<Employee>?> result =
        await networkManager.send<List<Employee>, Employee>(
            "/employee", HttpMethod.GET, Employee(), null, null);

    return result;
  }
}
