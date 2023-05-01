// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/model/response_model.dart';
import 'package:webapp/core/network/network_manager.dart';

import '../model/employee.dart';

class LoginService {
  final NetworkManager networkManager;
  final SecureStorage secureStorage;
  LoginService(
    this.secureStorage, {
    required this.networkManager,
  });

  Future<ResponseModel<Employee?>> login(String email, String password) async {
    ResponseModel<Employee> result =
        await networkManager.send<Employee, Employee>(
            "/login",
            HttpMethod.POST,
            Employee(),
            json.encode({'email': email, 'password': password}),
            null);
    if (result.data != null && !result.error!) {
      secureStorage.writeSecureData("refreshToken", result.data!.refreshToken!);
      secureStorage.writeSecureData("accessToken", result.data!.accessToken!);
    }
    return result;
  }

  //Employee modeli model boş yollanamayacağı için yollandı. Normalde response dönülmüyor.
  Future<ResponseModel> register(String email, String password) async {
    ResponseModel result = await networkManager.send<Employee, Employee>(
        "/auth/register",
        HttpMethod.POST,
        Employee(),
        json.encode({'email': email, 'password': password}),
        null);

    return result;
  }
}
