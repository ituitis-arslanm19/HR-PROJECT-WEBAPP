// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../core/base/base_model.dart';

class Department extends BaseModel<Department> {
  int? id;
  String? name;
  String? managerName;
  int? employeeNum;
  Department({
    this.id,
    this.name,
    this.managerName,
    this.employeeNum,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'managerName': managerName,
      'employeeNum': employeeNum,
    };
  }

  @override
  Department fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
      managerName:
          json['managerName'] != null ? json['managerName'] as String : null,
      employeeNum:
          json['employeeNum'] != null ? json['employeeNum'] as int : null,
    );
  }
}
