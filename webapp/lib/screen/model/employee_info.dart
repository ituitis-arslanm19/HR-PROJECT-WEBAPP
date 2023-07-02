import 'package:webapp/core/base/base_model.dart';
import 'package:webapp/screen/model/time_off.dart';

class EmployeeInfo extends BaseModel<EmployeeInfo> {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  int? departmentId;
  String? departmentName;
  int? remainingTimeOffDays;
  String? startDate;
  List<TimeOff>? previousTimeOffs;
  List<TimeOff>? waitingTimeOffs;
  EmployeeInfo({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.departmentId,
    this.departmentName,
    this.remainingTimeOffDays,
    this.startDate,
    this.previousTimeOffs,
    this.waitingTimeOffs,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'departmentId': departmentId,
      'departmentName': departmentName,
      'remainingTimeOffDays': remainingTimeOffDays,
      'startDate': startDate,
      'previousTimeOffs': previousTimeOffs != null
          ? previousTimeOffs!.map((x) => x.toJson()).toList()
          : [],
      'waitingTimeOffs': waitingTimeOffs != null
          ? waitingTimeOffs!.map((x) => x.toJson()).toList()
          : [],
    };
  }

  @override
  EmployeeInfo fromJson(Map<String, dynamic> json) {
    return EmployeeInfo(
      id: json['id'] != null ? json['id'] as int : null,
      email: json['email'] != null ? json['email'] as String : null,
      firstName: json['firstName'] != null ? json['firstName'] as String : null,
      lastName: json['lastName'] != null ? json['lastName'] as String : null,
      departmentId:
          json['departmentId'] != null ? json['departmentId'] as int : null,
      departmentName: json['departmentName'] != null
          ? json['departmentName'] as String
          : null,
      remainingTimeOffDays: json['remainingTimeOffDays'] != null
          ? json['remainingTimeOffDays'] as int
          : null,
      startDate: json['startDate'] != null ? json['startDate'] as String : null,
      previousTimeOffs: json['previousTimeOffs'] != null
          ? List<TimeOff>.from(json['previousTimeOffs']
              .map(
                (x) => TimeOff().fromJson(x),
              )
              .toList())
          : null,
      waitingTimeOffs: json['waitingTimeOffs'] != null
          ? List<TimeOff>.from(json['waitingTimeOffs']
              .map(
                (x) => TimeOff().fromJson(x),
              )
              .toList())
          : null,
    );
  }
}
