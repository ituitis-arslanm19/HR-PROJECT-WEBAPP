// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

import 'package:webapp/screen/model/sign_history.dart';

import '../../core/base/base_model.dart';
import '../../core/constant/enum/enums.dart';

class TimeOff extends BaseModel<TimeOff> {
  int? id;
  TimeOffStatus? status;
  String? startDate;
  String? endDate;
  List<String>? managersToSign;
  String? timeOffType;
  int? timeOffTypeId;
  List<SignHistory>? signHistories;
  String? description;
  TimeOff(
      {this.id,
      this.startDate,
      this.endDate,
      this.managersToSign,
      this.timeOffType,
      this.timeOffTypeId,
      this.signHistories,
      this.description,
      this.status});

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'startDate': startDate,
      'endDate': endDate,
      'managersToSign':
          managersToSign != null ? managersToSign!.map((x) => x).toList() : [],
      'timeOffType': timeOffType,
      'timeOffTypeId': timeOffTypeId,
      'signHistories': signHistories != null
          ? signHistories!.map((x) => x.toJson()).toList()
          : [],
      'description': description,
      'status': status != null ? status.toString() : null
    };
  }

  @override
  TimeOff fromJson(Map<String, dynamic> json) {
    TimeOffStatus timeOffStatusResult;
    switch (json['status'].toString()) {
      case "PENDING":
        timeOffStatusResult = TimeOffStatus.PENDING;
        break;
      case "DENIED":
        timeOffStatusResult = TimeOffStatus.DENIED;
        break;
      case "APPROVED":
        timeOffStatusResult = TimeOffStatus.APPROVED;
        break;
      default:
        timeOffStatusResult = TimeOffStatus.COMPLETED;

        break;
    }

    return TimeOff(
        id: json['id'] != null ? json['id'] as int : null,
        startDate: json['startDate'],
        endDate: json['endDate'],
        managersToSign: json['managersToSign'] != null
            ? List<String>.from(json['managersToSign'])
            : null,
        timeOffType:
            json['timeOffType'] != null ? json['timeOffType'] as String : null,
        timeOffTypeId:
            json['timeOffTypeId'] != null ? json['timeOffTypeId'] as int : null,
        signHistories: json['signHistories'] != null
            ? List<SignHistory>.from(json['signHistories']
                .map((json) => SignHistory().fromJson(json))
                .toList())
            : null,
        description:
            json['description'] != null ? json['description'] as String : null,
        status: timeOffStatusResult);
  }

  @override
  String toString() {
    return 'TimeOff(id: $id, startDate: $startDate, endDate: $endDate, managersToSign: $managersToSign, timeOffType: $timeOffType, timeOffTypeId: $timeOffTypeId, signHistories: $signHistories, description: $description)';
  }
}
