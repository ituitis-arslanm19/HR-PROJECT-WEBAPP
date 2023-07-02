// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import '../../../core/base/base_model.dart';

class GetPasswordChangeTokenRequest
    extends BaseModel<GetPasswordChangeTokenRequest> {
  String? email;
  String? code;

  GetPasswordChangeTokenRequest({
    this.email,
    this.code,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'code': code,
    };
  }

  @override
  GetPasswordChangeTokenRequest fromJson(Map<String, dynamic> json) {
    return GetPasswordChangeTokenRequest(
      email: json['email'],
      code: json['code'],
    );
  }

  @override
  String toString() => 'UpdateTimeOffRequest(email: $email, code: $code)';
}
