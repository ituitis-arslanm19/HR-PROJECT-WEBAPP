// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import '../../../core/base/base_model.dart';

class CreateTimeOffRequest extends BaseModel<CreateTimeOffRequest> {
  String? startDate;
  String? endDate;
  int? timeOffTypeId;

  CreateTimeOffRequest({
    this.startDate,
    this.endDate,
    this.timeOffTypeId,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'startDate': startDate,
      'endDate': endDate,
      'timeOffTypeId': timeOffTypeId,
    };
  }

  @override
  CreateTimeOffRequest fromJson(Map<String, dynamic> json) {
    return CreateTimeOffRequest(
      startDate: json['startDate'],
      endDate: json['endDate'],
      timeOffTypeId:
          json['timeOffTypeId'] != null ? json['timeOffTypeId'] as int : null,
    );
  }

  @override
  String toString() =>
      'CreateTimeOffRequest(startDate: $startDate, endDate: $endDate, timeOffTypeId: $timeOffTypeId)';
}
