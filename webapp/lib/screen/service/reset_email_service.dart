// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/model/response_model.dart';
import 'package:webapp/core/network/network_manager.dart';

import '../model/employee.dart';

class ResetEmailService {
  final NetworkManager networkManager;

  ResetEmailService({
    required this.networkManager,
  });

  Future<ResponseModel<Employee?>> sendEmailInfo(String email) async {
    ResponseModel<Employee?> result =
        await networkManager.send<Employee, Employee>("/auth/passwordReset",
            HttpMethod.POST, Employee(), json.encode({'email': email}), null);

    return result;
  }
}
