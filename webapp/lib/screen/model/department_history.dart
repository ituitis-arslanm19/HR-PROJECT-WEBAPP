import 'package:webapp/screen/model/shift.dart';

import '../../core/base/base_model.dart';

class DepartmentHistory extends BaseModel<DepartmentHistory>  {
  int? id;
  String? departmentName;
  String? positionName;
  Shift? shift;
  String? startDate;
  String? endDate;

  DepartmentHistory({this.id, this.departmentName, this.positionName, this.shift, this.startDate, this.endDate});

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'departmentName': departmentName,
      'positionName': positionName,
      'shift': shift?.toJson(),
      'startDate': startDate,
      'endDate': endDate
    };
  }

  @override
  DepartmentHistory fromJson(Map<String, dynamic> json) {
    return DepartmentHistory(
        id: json['id'] != null ? json['id'] as int : null,
        departmentName: 
            json['departmentName'] != null ? json['departmentName'] as String : null,
        positionName:
            json['positionName'] != null ? json['positionName'] as String : "",
        shift: json['shift'] != null
            ? Shift().fromJson(json["shift"])
            : null,
        startDate:
             json['startDate'] != null ? json['startDate'] as String : null,
        endDate: 
             json['endDate'] != null ? json['endDate'] as String : null);
  }
  }