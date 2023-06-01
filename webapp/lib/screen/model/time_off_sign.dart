// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../core/base/base_model.dart';


class TimeOffSign extends BaseModel<TimeOffSign> {
  int? id;
  String? firstName;
  String? lastName;
  String? startDate;
  String? endDate;
  String? timeOffType;
  String? description;

  TimeOffSign({
    this.id,
    this.firstName,
    this.lastName,
    this.startDate,
    this.endDate,
    this.timeOffType,
    this.description,
  });
  
  
  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'startDate': startDate,
      'endDate': endDate,
      'timeOffType': timeOffType,
      'description': description,
    };
  }

  @override
  TimeOffSign fromJson(Map<String, dynamic> map) {
    return TimeOffSign(
      id: map['id'] != null ? map['id'] as int : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      startDate: map['startDate'] != null ? map['startDate'] as String : null,
      endDate: map['endDate'] != null ? map['endDate'] as String : null,
      timeOffType: map['timeOffType'] != null ? map['timeOffType'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
    );
  }
}