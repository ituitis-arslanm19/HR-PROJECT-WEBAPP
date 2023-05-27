import 'package:flutter/foundation.dart';
import 'package:webapp/screen/model/site.dart';

import '../../core/base/base_model.dart';

class EmployeeDetail extends BaseModel<EmployeeDetail> {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? birthDate;
  String? startDate;
  int? departmentId;
  bool? isManager;
  int? remainingTimeOffDays;
  String? gender;
  List<Site>? siteList;
  int? identityNum;
  int? shiftId;

  EmployeeDetail(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.birthDate,
      this.startDate,
      this.departmentId,
      this.isManager,
      this.remainingTimeOffDays,
      this.gender,
      this.siteList,
      this.identityNum,
      this.shiftId});

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'birthDate': birthDate,
      'startDate': startDate,
      'departmentId': departmentId,
      'isManager': isManager,
      'remainingTimeOffDays': remainingTimeOffDays,
      'gender': gender,
      'siteIdList': siteList!.map((x) => x.id).toList(),
      'identityNum': identityNum,
      'shiftId': shiftId
    };
  }

  @override
  EmployeeDetail fromJson(Map<String, dynamic> map) {
    return EmployeeDetail(
      id: map['id'] != null ? map['id'] as int : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      birthDate: map['birthDate'] != null ? map['birthDate'] as String : null,
      startDate: map['startDate'] != null ? map['startDate'] as String : null,
      departmentId:
          map['departmentId'] != null ? map['departmentId'] as int : null,
      isManager: map['isManager'] != null ? map['isManager'] as bool : null,
      remainingTimeOffDays: map['remainingTimeOffDays'] != null
          ? map['remainingTimeOffDays'] as int
          : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      siteList: map['siteList'] != null
          ? List<Site>.from(
              map['siteList'].map((json) => Site().fromJson(json)).toList())
          : null,
      identityNum:
          map['identityNum'] != null ? map['identityNum'] as int : null,
      shiftId: map['shiftId'] != null ? map['shiftId'] as int : null,
    );
  }

  @override
  bool operator ==(covariant EmployeeDetail other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.birthDate == birthDate &&
        other.startDate == startDate &&
        other.departmentId == departmentId &&
        other.isManager == isManager &&
        other.remainingTimeOffDays == remainingTimeOffDays &&
        other.gender == gender &&
        listEquals(other.siteList, siteList) &&
        other.identityNum == identityNum &&
        other.shiftId == shiftId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        birthDate.hashCode ^
        startDate.hashCode ^
        departmentId.hashCode ^
        isManager.hashCode ^
        remainingTimeOffDays.hashCode ^
        gender.hashCode ^
        siteList.hashCode ^
        identityNum.hashCode ^
        shiftId.hashCode;
  }
}
