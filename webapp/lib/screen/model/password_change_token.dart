// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

import 'package:webapp/screen/model/sign_history.dart';

import '../../../core/base/base_model.dart';
import '../../../core/constant/enum/enums.dart';

class PasswordChangeToken extends BaseModel<PasswordChangeToken> {
  String? token;

  PasswordChangeToken({
    this.token,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'token': token,
    };
  }

  @override
  PasswordChangeToken fromJson(Map<String, dynamic> json) {
    return PasswordChangeToken(
      token: json['token'],
    );
  }

  @override
  String toString() => 'PasswordChangeToken( token: $token)';
}
