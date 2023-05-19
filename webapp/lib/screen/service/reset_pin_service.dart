// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/model/response_model.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/screen/model/password_change_token.dart';
import 'package:webapp/screen/model/request/get_password_change_token_request.dart';

import '../../core/cache/secure_storage.dart';
import '../model/mobile_client.dart';

class ResetPinService {
  final NetworkManager networkManager;

  ResetPinService({
    required this.networkManager,
  });

  Future<ResponseModel<PasswordChangeToken?>> getPasswordChangeToken(
      GetPasswordChangeTokenRequest getPasswordChangeTokenRequest) async {
    ResponseModel<PasswordChangeToken?> result =
        await networkManager.send<PasswordChangeToken, PasswordChangeToken>(
            "/auth/passwordResetPin",
            HttpMethod.POST,
            PasswordChangeToken(),
            json.encode(getPasswordChangeTokenRequest.toJson()),
            null);

    return result;
  }
}
