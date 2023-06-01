// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/constant/enum/enums.dart';

import '../../core/constant/strings.dart';
import '../../core/network/model/response_model.dart';
import '../../core/network/network_manager.dart';
import '../model/employee.dart';
import '../model/employee_list_item.dart';
import '../model/employee_detail.dart';

class EmployeeService {
  NetworkManager networkManager;
  EmployeeService({
    required this.networkManager,
  });

  Future<List<Employee>?> getEmployees() async {
    ResponseModel<List<Employee>> result =
        await networkManager.send<List<Employee>, Employee>(
            "/employee", HttpMethod.GET, Employee(), null, null);
    return result.data;
  }

  Future<List<Employee>?> getManagers() async {
    ResponseModel<List<Employee>> result =
        await networkManager.send<List<Employee>, Employee>(
            "/employee/managers", HttpMethod.GET, Employee(), null, null);
    return result.data;
  }

  Future<EmployeeDetail?> getEmployeeDetail(int id) async {
    ResponseModel<EmployeeDetail?> result =
        await networkManager.send<EmployeeDetail, EmployeeDetail>(
            "/employee/popup/$id", HttpMethod.GET, EmployeeDetail(), null, null);
    return result.data;
  }

  Future<EmployeeDetail?> updateEmployee(EmployeeDetail employeeDetail) async {
    ResponseModel<EmployeeDetail?> result =
        await networkManager.send<EmployeeDetail, EmployeeDetail>(
            "/employee",
            HttpMethod.PUT,
            EmployeeDetail(),
            json.encode(employeeDetail.toJson()),
            null);
    return result.data;
  }

  Future<EmployeeDetail?> create(EmployeeDetail employeeDetail) async {
    ResponseModel<EmployeeDetail?> result =
        await networkManager.send<EmployeeDetail, EmployeeDetail>(
            "/employee",
            HttpMethod.POST,
            EmployeeDetail(),
            json.encode(employeeDetail.toJson()),
            null);
    return result.data;
  }

  Future<bool?> delete(int id) async {
    ResponseModel<EmployeeDetail?> result =
        await networkManager.send<EmployeeDetail, EmployeeDetail>(
            "/employee/$id",
            HttpMethod.DELETE,
            EmployeeDetail(),
            null,
            TOKEN);
    return result.error;
}
  
}
