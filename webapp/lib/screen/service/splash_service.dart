// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/model/response_model.dart';
import 'package:webapp/core/network/network_manager.dart';

import '../../core/cache/secure_storage.dart';
import '../model/mobile_client.dart';

class SplashService {
  final NetworkManager networkManager;
  final SecureStorage secureStorage;

  SplashService(
    this.secureStorage, {
    required this.networkManager,
  });

  Future<ResponseModel<MobileClient?>> authenticate() async {
    String? refreshToken = await secureStorage.readSecureData("refreshToken");

    ResponseModel<MobileClient?> result =
        await networkManager.send<MobileClient, MobileClient>(
            "/auth/newAccessToken",
            HttpMethod.GET,
            MobileClient(),
            null,
            '$refreshToken');

    if (!result.error! && result.data != null) {
      secureStorage.writeSecureData("refreshToken", result.data!.refreshToken!);
      secureStorage.writeSecureData("accessToken", result.data!.accessToken!);
    }
    return result;
  }
}
