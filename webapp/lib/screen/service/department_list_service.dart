import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/screen/model/dashboard/dashboard.dart';
import 'package:webapp/screen/model/employee.dart';

import '../../core/constant/enum/enums.dart';
import '../../core/network/model/response_model.dart';
import '../model/department.dart';

class DepartmentListService {
  final NetworkManager networkManager;

  DepartmentListService(this.networkManager);

  Future<ResponseModel<List<Department>?>> getDepartmentList() async {
    ResponseModel<List<Department>?> result =
        await networkManager.send<List<Department>, Department>(
            "/employee", HttpMethod.GET, Department(), null, null);

    return result;
  }
}
