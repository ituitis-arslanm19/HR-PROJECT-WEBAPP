import 'dart:core';

import '../../../core/base/base_model.dart';

class UpdateTimeOffRequest extends BaseModel<UpdateTimeOffRequest> {
  int? timeOffId;
  String? status;

  UpdateTimeOffRequest({
    this.timeOffId,
    this.status,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'timeOffId': timeOffId,
      'status': status,
    };
  }

  @override
  UpdateTimeOffRequest fromJson(Map<String, dynamic> json) {
    return UpdateTimeOffRequest(
      timeOffId: json['timeOffId'],
      status: json['status'],
    );
  }

  @override
  String toString() =>
      'UpdateTimeOffRequest(timeOffId: $timeOffId, status: $status)';
}
