import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/screen/model/dashboard/dashboard.dart';
import 'package:webapp/screen/model/employee_list_item.dart';

import '../../core/constant/enum/enums.dart';
import '../../core/network/model/response_model.dart';
import '../model/department_info.dart';
import '../model/employee_info.dart';

class DepartmentInfoService {
  final NetworkManager networkManager;

  DepartmentInfoService(this.networkManager);

  Future<ResponseModel<DepartmentInfo>> getDepartmentInfo(int id) async {
    ResponseModel<DepartmentInfo> result =
        await networkManager.send<DepartmentInfo, DepartmentInfo>(
            "/department/detail/$id",
            HttpMethod.GET,
            DepartmentInfo(),
            null,
            null);

    return result;
  }
}
