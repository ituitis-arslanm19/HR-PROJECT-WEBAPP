// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/constant/enum/enums.dart';

import '../../core/base/base_model.dart';

class SignHistory extends BaseModel<SignHistory> {
  String? managerName;
  String? managerLastName;
  TimeOffStatus? status;
  SignHistory({
    this.managerName,
    this.managerLastName,
    this.status,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'managerName': managerName,
      'managerLastName': managerLastName,
      'status': status?.toString(),
    };
  }

  @override
  SignHistory fromJson(Map<String, dynamic> map) {
    TimeOffStatus? timeOffStatusResult;
    switch (map['status'].toString()) {
      case "APPROVED":
        timeOffStatusResult = TimeOffStatus.APPROVED;
        break;
      case "PENDING":
        timeOffStatusResult = TimeOffStatus.PENDING;
        break;
      case "DENIED":
        timeOffStatusResult = TimeOffStatus.DENIED;
        break;
    }

    return SignHistory(
      managerName:
          map['managerName'] != null ? map['managerName'] as String : null,
      managerLastName: map['managerLastName'] != null
          ? map['managerLastName'] as String
          : null,
      status: map['status'] != null ? timeOffStatusResult : null,
    );
  }
}
