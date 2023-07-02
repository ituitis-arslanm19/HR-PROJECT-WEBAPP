import 'package:webapp/core/base/base_model.dart';

class Profile extends BaseModel<Profile> {
  String? firstName;
  String? lastName;
  String? email;
  String? birthDate;
  String? department;
  String? startDate;
  int? remainingTimeOffDays;

  Profile({
    this.firstName,
    this.lastName,
    this.email,
    this.birthDate,
    this.department,
    this.startDate,
    this.remainingTimeOffDays,
  });

  Profile fromJson(Map<String, dynamic> json) {
    return Profile(
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        birthDate: json['birthDate'],
        startDate: json['startDate'],
        department: json['department'],
        remainingTimeOffDays: json['remainingTimeOffDays']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'birthDate': birthDate,
      'startDate': startDate,
      'department': department,
      'remainingTimeOffDays': remainingTimeOffDays,
    };
  }

  @override
  String toString() {
    return 'Profile(firstName: $firstName, lastName: $lastName, email: $email, birthDate: $birthDate, startDate: $startDate, department: $department, remainingTimeOffDays: $remainingTimeOffDays)';
  }
}
