// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import '../../../core/base/base_model.dart';

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
