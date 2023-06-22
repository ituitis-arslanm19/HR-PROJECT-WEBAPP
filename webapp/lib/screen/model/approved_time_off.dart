// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import '../../core/base/base_model.dart';
import '../../core/constant/enum/enums.dart';

class ApprovedTimeOff extends BaseModel<ApprovedTimeOff> {
  int? id;
  TimeOffStatus? status;
  String? startDate;
  String? endDate;
  String? firstName;
  String? lastName;
  String? timeOffType;
  String? description;
  ApprovedTimeOff(
      {this.id,
      this.startDate,
      this.endDate,
      this.firstName,
      this.lastName,
      this.timeOffType,
      this.description,
      this.status});

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'startDate': startDate,
      'endDate': endDate,
      'firstName': firstName,
      'lastName': lastName,
      'timeOffType': timeOffType,
      'description': description,
      'status': status != null ? status.toString() : null
    };
  }

  @override
  ApprovedTimeOff fromJson(Map<String, dynamic> json) {
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
        timeOffStatusResult = TimeOffStatus.PENDING;

        break;
    }

    return ApprovedTimeOff(
        id: json['id'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        timeOffType:
            json['timeOffType'] != null ? json['timeOffType'] as String : null,
        description:
            json['description'] != null ? json['description'] as String : null,
        status: timeOffStatusResult);
  }

  @override
  String toString() {
    return 'ApprovedTimeOff(id: $id, status: $status, startDate: $startDate, endDate: $endDate, firstName: $firstName, lastName: $lastName, timeOffType: $timeOffType, description: $description)';
  }
}
