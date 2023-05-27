// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/constant/strings.dart';

import '../../core/network/model/response_model.dart';
import '../../core/network/network_manager.dart';
import '../model/department.dart';
import '../model/department_list_item.dart';
import '../model/department_detail.dart';

class DepartmentService {
  NetworkManager networkManager;
  DepartmentService({
    required this.networkManager,
  });

  Future<List<Department>?> getDepartments() async {
    ResponseModel<List<Department>> result =
        await networkManager.send<List<Department>, Department>(
            "/department", HttpMethod.GET, Department(), null, TOKEN);
    return result.data;
  }

  Future<DepartmentDetail?> getDepartmentDetail(int id) async {
    ResponseModel<DepartmentDetail?> result =
        await networkManager.send<DepartmentDetail, DepartmentDetail>(
            "/department/popup/$id",
            HttpMethod.GET,
            DepartmentDetail(),
            null,
            TOKEN);
    return result.data;
  }

  Future<DepartmentDetail?> updateDepartment(
      DepartmentDetail departmentDetail) async {
    ResponseModel<DepartmentDetail?> result =
        await networkManager.send<DepartmentDetail, DepartmentDetail>(
            "/department",
            HttpMethod.PUT,
            DepartmentDetail(),
            json.encode(departmentDetail.toJson()),
            null);
    return result.data;
  }

  Future<DepartmentDetail?> create(DepartmentDetail departmentDetail) async {
    ResponseModel<DepartmentDetail?> result =
        await networkManager.send<DepartmentDetail, DepartmentDetail>(
            "/department",
            HttpMethod.POST,
            DepartmentDetail(),
            json.encode(departmentDetail.toJson()),
            null);
    return result.data;
  }
}
