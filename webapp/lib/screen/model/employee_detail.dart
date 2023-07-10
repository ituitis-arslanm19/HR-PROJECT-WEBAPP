// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:webapp/screen/model/department_history.dart';

import 'package:webapp/screen/model/site.dart';
import 'package:webapp/screen/model/time_off.dart';

import '../../core/base/base_model.dart';
import 'asset.dart';

class EmployeeDetail extends BaseModel<EmployeeDetail> {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? birthDate;
  String? startDate;
  int? departmentId;
  String? departmentName;
  String? phoneNumber;
  List<String>? roles;
  int? remainingTimeOffDays;
  String? gender;
  List<Site>? siteList;
  String? identityNum;
  int? shiftId;
  String? seniorityDate;
  String? emergencyContactName;
  String? emergencyContactNumber;
  String? address;
  List<String>? departmentHistory;
  List<TimeOff>? previousTimeOffs;
  List<TimeOff>? waitingTimeOffs;
  List<Asset>? productList;
  List<DepartmentHistory>? departmentHistories;

  EmployeeDetail({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.birthDate,
    this.startDate,
    this.departmentId,
    this.departmentName,
    this.roles,
    this.remainingTimeOffDays,
    this.gender,
    this.siteList,
    this.identityNum,
    this.shiftId,
    this.phoneNumber,
    this.seniorityDate,
    this.emergencyContactName,
    this.emergencyContactNumber,
    this.address,
    this.departmentHistory,
    this.previousTimeOffs,
    this.waitingTimeOffs,
    this.productList,
    this.departmentHistories
  });

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
      'departmentName': departmentName,
      'phoneNumber': phoneNumber,
      'address': address,
      'seniorityDate': seniorityDate,
      'emergencyContactName': emergencyContactName,
      'emergencyContactNumber': emergencyContactNumber,
      'roles': roles != null ? roles!.map((x) => x).toList() : [],
      'remainingTimeOffDays': remainingTimeOffDays,
      'gender': gender,
      'siteIdList': siteList!.map((x) => x.id).toList(),
      'identityNum': identityNum,
      'shiftId': shiftId,
      'departmentHistory': departmentHistory ?? [],
      'previousTimeOffs': previousTimeOffs != null
          ? previousTimeOffs!.map((e) => e.toJson()).toList()
          : [],
      'waitingTimeOffs': waitingTimeOffs != null
          ? waitingTimeOffs!.map((e) => e.toJson()).toList()
          : [],
      'productList': productList != null
          ? productList!.map((e) => e.toJson()).toList()
          : [],
      'departmentHistories': departmentHistories != null
          ? departmentHistories!.map((e) => e.toJson()).toList()
          : []
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
      departmentName: map['departmentName'] != null
          ? map['departmentName'] as String
          : null,
      roles: map['roles'] != null ? List<String>.from(map['roles']) : null,
      remainingTimeOffDays: map['remainingTimeOffDays'] != null
          ? map['remainingTimeOffDays'] as int
          : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      siteList: map['siteList'] != null
          ? List<Site>.from(
              map['siteList'].map((json) => Site().fromJson(json)).toList())
          : null,
      identityNum:
          map['identityNum'] != null ? map['identityNum'] as String : null,
      shiftId: map['shiftId'] != null ? map['shiftId'] as int : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      seniorityDate:
          map['seniorityDate'] != null ? map['seniorityDate'] as String : null,
      emergencyContactName: map['emergencyContactName'] != null
          ? map['emergencyContactName'] as String
          : null,
      emergencyContactNumber: map['emergencyContactNumber'] != null
          ? map['emergencyContactNumber'] as String
          : null,
      address: map['address'] != null ? map['address'] as String : null,
      departmentHistory: map['departmentHistory'] != null
          ? List<String>.from(map['departmentHistory'])
          : null,
      previousTimeOffs: map['previousTimeOffs'] != null
          ? List<TimeOff>.from(map['previousTimeOffs']
              .map((json) => TimeOff().fromJson(json))
              .toList())
          : null,
      waitingTimeOffs: map['waitingTimeOffs'] != null
          ? List<TimeOff>.from(map['waitingTimeOffs']
              .map((json) => TimeOff().fromJson(json))
              .toList())
          : null,
      productList: map['productList'] != null
          ? List<Asset>.from(
              map['productList'].map((json) => Asset().fromJson(json)).toList())
          : null,
      departmentHistories: map['departmentHistories'] != null
          ? List<DepartmentHistory>.from(
              map['departmentHistories'].map((json) => DepartmentHistory().fromJson(json)).toList())
            : null
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
        listEquals(other.roles, roles) &&
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
        roles.hashCode ^
        remainingTimeOffDays.hashCode ^
        gender.hashCode ^
        siteList.hashCode ^
        identityNum.hashCode ^
        shiftId.hashCode;
  }

  @override
  String toString() {
    return 'EmployeeDetail(id: $id, firstName: $firstName, lastName: $lastName, email: $email, birthDate: $birthDate, startDate: $startDate, departmentId: $departmentId, departmentName: $departmentName, phoneNumber: $phoneNumber, roles: $roles, remainingTimeOffDays: $remainingTimeOffDays, gender: $gender, siteList: $siteList, identityNum: $identityNum, shiftId: $shiftId, seniorityDate: $seniorityDate, emergencyContactName: $emergencyContactName, emergencyContactNumber: $emergencyContactNumber, address: $address, departmentHistory: $departmentHistory, previousTimeOffs: $previousTimeOffs, waitingTimeOffs: $waitingTimeOffs, productList: $productList, departmentHistories: $departmentHistories)';
  }
}
