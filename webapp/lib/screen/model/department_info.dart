import 'package:webapp/core/base/base_model.dart';

import 'dashboard/gender_pie_chart.dart';
import 'employee.dart';

class DepartmentInfo extends BaseModel<DepartmentInfo> {
  int? id;
  String? name;
  String? managerName;
  String? parentDepartmentName;
  String? managerShift;
  String? managerEmail;
  int? managerId;
  int? employeeNum;
  List<Employee>? employeeList;
  GenderPieChart? genderPieChart;

  DepartmentInfo({
    this.id,
    this.name,
    this.managerName,
    this.parentDepartmentName,
    this.managerShift,
    this.managerEmail,
    this.managerId,
    this.employeeNum,
    this.employeeList,
    this.genderPieChart,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'managerName': managerName,
      'parentDepartmentName': parentDepartmentName,
      'managerId': managerId,
      'employeeNum': employeeNum,
      'managerShift': managerShift,
      'managerEmail': managerEmail,
      'employeeList': employeeList != null
          ? employeeList!.map((x) => x.toJson()).toList()
          : [],
      'genderPieChart': genderPieChart?.toJson(),
    };
  }

  @override
  DepartmentInfo fromJson(Map<String, dynamic> json) {
    return DepartmentInfo(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
      managerName:
          json['managerName'] != null ? json['managerName'] as String : null,
      parentDepartmentName: json['parentDepartmentName'] != null
          ? json['parentDepartmentName'] as String
          : null,
      managerId: json['managerId'] != null ? json['managerId'] as int : null,
      employeeNum:
          json['employeeNum'] != null ? json['employeeNum'] as int : null,
      managerShift:
          json['managerShift'] != null ? json['managerShift'] as String : null,
      managerEmail:
          json['managerEmail'] != null ? json['managerEmail'] as String : null,
      employeeList: json['employeeList'] != null
          ? List<Employee>.from(json['employeeList']
              .map((json) => Employee().fromJson(json))
              .toList())
          : null,
      genderPieChart: json['genderPieChart'] != null
          ? GenderPieChart().fromJson(json['genderPieChart'])
          : null,
    );
  }
}
