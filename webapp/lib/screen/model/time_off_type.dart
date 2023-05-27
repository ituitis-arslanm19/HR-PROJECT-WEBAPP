// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:webapp/core/base/base_model.dart';

class TimeOffType extends BaseModel<TimeOffType> {
  int? id;
  String? name;
  String? description;
  TimeOffType({
    this.id,
    this.name,
    this.description,
  });

  @override
  TimeOffType fromJson(Map<String, dynamic> json) {
    return TimeOffType(
        id: json['id'], name: json['name'], description: json['description']);
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description
    };
  }
}
