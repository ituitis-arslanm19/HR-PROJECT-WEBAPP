import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/screen/model/dashboard/dashboard.dart';
import 'package:webapp/screen/model/employee_list_item.dart';

import '../../core/constant/enum/enums.dart';
import '../../core/network/model/response_model.dart';
import '../model/department_list_item.dart';

class DepartmentListService {
  final NetworkManager networkManager;

  DepartmentListService(this.networkManager);

  Future<ResponseModel<List<DepartmentListItem>?>> getDepartmentList() async {
    ResponseModel<List<DepartmentListItem>?> result =
        await networkManager.send<List<DepartmentListItem>, DepartmentListItem>(
            "/department", HttpMethod.GET, DepartmentListItem(), null, null);

    return result;
  }
}
