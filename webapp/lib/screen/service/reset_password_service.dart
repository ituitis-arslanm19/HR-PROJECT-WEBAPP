// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/model/response_model.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/screen/model/password_change_token.dart';
import 'package:webapp/screen/model/request/get_password_change_token_request.dart';
import 'package:webapp/screen/model/request/update_password_request.dart';

import '../../core/cache/secure_storage.dart';
import '../model/employee.dart';

class ResetPasswordService {
  final NetworkManager networkManager;

  ResetPasswordService({
    required this.networkManager,
  });

  Future<ResponseModel> updatePassword(
      UpdatePasswordRequest updatePasswordRequest) async {
    ResponseModel<Employee?> result =
        await networkManager.send<Employee, Employee>(
            "/auth/passwordReset",
            HttpMethod.PUT,
            Employee(),
            json.encode(updatePasswordRequest.toJson()),
            null);

    return result;
  }
}