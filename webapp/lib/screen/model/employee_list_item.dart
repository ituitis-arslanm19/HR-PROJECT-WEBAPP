import '../../core/base/base_model.dart';

class EmployeeListItem extends BaseModel<EmployeeListItem> {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? departmentName;
  EmployeeListItem({
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
    return EmployeeListItem(
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
