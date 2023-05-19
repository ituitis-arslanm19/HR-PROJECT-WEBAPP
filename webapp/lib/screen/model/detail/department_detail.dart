// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/base/base_model.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/screen/model/time_off.dart';

class DepartmentDetail extends BaseModel<DepartmentDetail> {
  int? id;
  String? name;
  String? managerName;
  String? lastName;
  int? managerId;
  int? employeeNum;

  DepartmentDetail({
    this.id,
    this.name,
    this.managerName,
    this.lastName,
    this.managerId,
    this.employeeNum,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'managerName': managerName,
      'lastName': lastName,
      'managerId': managerId,
      'employeeNum': employeeNum,
    };
  }

  @override
  DepartmentDetail fromJson(Map<String, dynamic> json) {
    return DepartmentDetail(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
      managerName:
          json['managerName'] != null ? json['managerName'] as String : null,
      lastName: json['lastName'] != null ? json['lastName'] as String : null,
      managerId: json['managerId'] != null ? json['managerId'] as int : null,
      employeeNum:
          json['employeeNum'] != null ? json['employeeNum'] as int : null,
    );
  }
}
