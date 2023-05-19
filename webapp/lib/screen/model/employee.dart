// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../core/base/base_model.dart';

class Employee extends BaseModel<Employee> {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? departmentName;
  Employee({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.departmentName,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'departmentName': departmentName,
    };
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] != null ? json['id'] as int : null,
      email: json['email'] != null ? json['email'] as String : null,
      firstName: json['firstName'] != null ? json['firstName'] as String : null,
      lastName: json['lastName'] != null ? json['lastName'] as String : null,
      departmentName: json['departmentName'] != null
          ? json['departmentName'] as String
          : null,
    );
  }
}
