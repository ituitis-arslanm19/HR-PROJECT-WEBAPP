// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

import 'package:webapp/screen/model/sign_history.dart';

import '../../../core/base/base_model.dart';
import '../../../core/constant/enum/enums.dart';

class UpdatePasswordRequest extends BaseModel<UpdatePasswordRequest> {
  String? token;
  String? password;

  UpdatePasswordRequest({this.token, this.password});

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'token': token,
      'password': password,
    };
  }

  @override
  UpdatePasswordRequest fromJson(Map<String, dynamic> json) {
    return UpdatePasswordRequest(
      token: json['token'],
      password: json['password'],
    );
  }

  @override
  String toString() =>
      'UpdatePasswordRequest( token: $token, password: $password)';
}
