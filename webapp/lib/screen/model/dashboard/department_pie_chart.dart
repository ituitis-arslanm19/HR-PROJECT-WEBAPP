import 'package:webapp/core/base/base_model.dart';

class DepartmentPieChart extends BaseModel<DepartmentPieChart> {
  String? departmentName;
  int? employeeNum;
  DepartmentPieChart({
    this.departmentName,
    this.employeeNum,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'departmentName': departmentName,
      'employeeNum': employeeNum,
    };
  }

  @override
  DepartmentPieChart fromJson(Map<String, dynamic> json) {
    return DepartmentPieChart(
      departmentName: json['departmentName'] != null
          ? json['departmentName'] as String
          : null,
      employeeNum:
          json['employeeNum'] != null ? json['employeeNum'] as int : null,
    );
  }
}
