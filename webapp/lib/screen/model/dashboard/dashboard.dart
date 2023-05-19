// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/base/base_model.dart';
import 'package:webapp/screen/model/dashboard/department_pie_chart.dart';
import 'package:webapp/screen/model/dashboard/gender_pie_chart.dart';
import 'package:webapp/screen/model/dashboard/upcoming_birthday.dart';

class Dashboard extends BaseModel<Dashboard> {
  List<DepartmentPieChart>? departmentPieChart;
  GenderPieChart? genderPieChart;
  List<UpcomingBirthday>? birthdays;
  Dashboard({
    this.departmentPieChart,
    this.genderPieChart,
    this.birthdays,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'departmentPieChart': departmentPieChart != null
          ? departmentPieChart!.map((x) => x.toJson()).toList()
          : [],
      'genderPieChart': genderPieChart?.toJson(),
      'birthdays':
          birthdays != null ? birthdays!.map((x) => x.toJson()).toList() : [],
    };
  }

  @override
  Dashboard fromJson(Map<String, dynamic> json) {
    return Dashboard(
      departmentPieChart: json['departmentPieChart'] != null
          ? List<DepartmentPieChart>.from(
              (json['departmentPieChart'])
                  .map(
                    (x) => DepartmentPieChart().fromJson(x),
                  )
                  .toList(),
            )
          : null,
      genderPieChart: json['genderPieChart'] != null
          ? GenderPieChart().fromJson(json['genderPieChart'])
          : null,
      birthdays: json['birthdays'] != null
          ? List<UpcomingBirthday>.from(
              (json['birthdays'])
                  .map(
                    (x) => UpcomingBirthday().fromJson(x),
                  )
                  .toList(),
            )
          : null,
    );
  }
}
