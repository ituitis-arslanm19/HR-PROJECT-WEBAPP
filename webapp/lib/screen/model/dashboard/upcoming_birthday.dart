// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/base/base_model.dart';

class UpcomingBirthday extends BaseModel<UpcomingBirthday> {
  String? name;
  String? birthday;
  UpcomingBirthday({
    this.name,
    this.birthday,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'birthday': birthday,
    };
  }

  @override
  UpcomingBirthday fromJson(Map<String, dynamic> json) {
    return UpcomingBirthday(
      name: json['name'] != null ? json['name'] as String : null,
      birthday: json['birthday'] != null ? json['birthday'] as String : null,
    );
  }
}
