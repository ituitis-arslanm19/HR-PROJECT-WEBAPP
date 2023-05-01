// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/model/response_model.dart';
import 'package:webapp/core/network/network_manager.dart';

import '../../core/cache/secure_storage.dart';
import '../model/employee.dart';

class SplashService {
  final NetworkManager networkManager;
  final SecureStorage secureStorage;

  SplashService(
    this.secureStorage, {
    required this.networkManager,
  });

  Future<ResponseModel<Employee?>> authenticate() async {
    String? refreshToken = await secureStorage.readSecureData("refreshToken");

    ResponseModel<Employee?> result =
        await networkManager.send<Employee, Employee>("/auth/newAccessToken",
            HttpMethod.GET, Employee(), null, '$refreshToken');

    if (!result.error! && result.data != null) {
      secureStorage.writeSecureData("refreshToken", result.data!.refreshToken!);
      secureStorage.writeSecureData("accessToken", result.data!.accessToken!);
    }
    return result;
  }
}
