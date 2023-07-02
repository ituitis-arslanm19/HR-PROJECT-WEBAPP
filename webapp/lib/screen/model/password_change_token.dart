import 'dart:core';

import '../../../core/base/base_model.dart';

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
