// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/model/response_model.dart';
import 'package:webapp/core/network/network_manager.dart';

import '../model/mobile_client.dart';

class LoginService {
  final NetworkManager networkManager;
  final SecureStorage secureStorage;
  LoginService(
    this.secureStorage, {
    required this.networkManager,
  });

  Future<ResponseModel<MobileClient?>> login(
      String email, String password) async {
    ResponseModel<MobileClient> result =
        await networkManager.send<MobileClient, MobileClient>(
            "/login",
            HttpMethod.POST,
            MobileClient(),
            json.encode({'email': email, 'password': password}),
            null);
    if (result.data != null && !result.error!) {
      secureStorage.writeSecureData("refreshToken", result.data!.refreshToken!);
      secureStorage.writeSecureData("accessToken", result.data!.accessToken!);
    }
    return result;
  }

  //MobileClient modeli model boş yollanamayacağı için yollandı. Normalde response dönülmüyor.
  Future<ResponseModel> register(String email, String password) async {
    ResponseModel result =
        await networkManager.send<MobileClient, MobileClient>(
            "/auth/register",
            HttpMethod.POST,
            MobileClient(),
            json.encode({'email': email, 'password': password}),
            null);

    return result;
  }
}
