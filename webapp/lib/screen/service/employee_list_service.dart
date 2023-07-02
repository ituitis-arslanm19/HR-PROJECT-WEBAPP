import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/screen/model/employee_list_item.dart';

import '../../core/constant/enum/enums.dart';
import '../../core/network/model/response_model.dart';

class EmployeeListService {
  final NetworkManager networkManager;
  final ClientType clientType;

  EmployeeListService(this.networkManager, this.clientType);

  Future<ResponseModel<List<EmployeeListItem>?>> getEmployeeList() async {
    ResponseModel<List<EmployeeListItem>?> result =
        await networkManager.send<List<EmployeeListItem>, EmployeeListItem>(
            clientType == ClientType.MANAGER
                ? "/employee/department"
                : "/employee",
            HttpMethod.GET,
            EmployeeListItem(),
            null,
            null);

    return result;
  }
}
