// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/base/base_model.dart';
import 'package:webapp/core/constant/enum/enums.dart';

class MobileClient extends BaseModel<MobileClient> {
  String? accessToken;
  String? refreshToken;
  ClientType? clientType;
  MobileClient({this.accessToken, this.refreshToken, this.clientType});

  @override
  MobileClient fromJson(Map<String, dynamic> json) {
    ClientType clientTypeResult = ClientType.EMPLOYEE;
    switch (json['clientType'].toString()) {
      case "EMPLOYEE":
        clientTypeResult = ClientType.EMPLOYEE;
        break;
      case "MANAGER":
        clientTypeResult = ClientType.MANAGER;
        break;

      case "HR":
        clientTypeResult = ClientType.HR;
        break;
      case "ADMIN":
        clientTypeResult = ClientType.ADMIN;
        break;
    }
    return MobileClient(
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
      'MobileClient(accessToken: $accessToken, refreshToken: $refreshToken, clientType: $clientType)';
}
