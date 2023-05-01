// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/base/base_model.dart';
import 'package:webapp/core/constant/enum/enums.dart';

class Employee extends BaseModel<Employee> {
  String? accessToken;
  String? refreshToken;
  ClientType? clientType;
  Employee({this.accessToken, this.refreshToken, this.clientType});

  @override
  Employee fromJson(Map<String, dynamic> json) {
    ClientType clientTypeResult = ClientType.USER;
    switch (json['clientType'].toString()) {
      case "EMPLOYEE":
        clientTypeResult = ClientType.EMPLOYEE;
        break;
      case "MANAGER":
        clientTypeResult = ClientType.MANAGER;
        break;
    }
    return Employee(
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
        clientType: clientTypeResult);
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'clienType': clientType.toString(),
    };
  }

  @override
  String toString() =>
      'Employee(accessToken: $accessToken, refreshToken: $refreshToken, clientType: $clientType)';
}
