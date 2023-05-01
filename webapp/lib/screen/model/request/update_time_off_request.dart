// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

import 'package:webapp/screen/model/sign_history.dart';

import '../../../core/base/base_model.dart';
import '../../../core/constant/enum/enums.dart';

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
