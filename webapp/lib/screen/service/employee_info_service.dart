import 'package:webapp/core/network/network_manager.dart';

import '../../core/constant/enum/enums.dart';
import '../../core/network/model/response_model.dart';
import '../model/employee_info.dart';

class EmployeeInfoService {
  final NetworkManager networkManager;

  EmployeeInfoService(this.networkManager);

  Future<ResponseModel<EmployeeInfo>> getEmployeeInfo(int id) async {
    ResponseModel<EmployeeInfo> result =
        await networkManager.send<EmployeeInfo, EmployeeInfo>(
            "/employee/detail/$id", HttpMethod.GET, EmployeeInfo(), null, null);

    return result;
  }
}
