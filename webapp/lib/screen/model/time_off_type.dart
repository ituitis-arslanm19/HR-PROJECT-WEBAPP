// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:webapp/core/base/base_model.dart';

class TimeOffType extends BaseModel<TimeOffType> {
  int? id;
  String? name;
  TimeOffType({this.id, this.name});

  @override
  TimeOffType fromJson(Map<String, dynamic> json) {
    return TimeOffType(id: json['id'], name: json['name']);
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'name': name};
  }
}