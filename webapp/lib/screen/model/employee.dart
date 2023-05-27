import '../../core/base/base_model.dart';

class Employee extends BaseModel<Employee> {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? departmentName;

  Employee(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.departmentName});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['departmentName'] = departmentName;
    return data;
  }

  @override
  Employee fromJson(Map<String, dynamic> json) {
    return Employee(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        departmentName: json['departmentName']);
  }

  @override
  String toString() {
    return 'Employee(id: $id, firstName: $firstName, lastName: $lastName, email: $email, department: $departmentName)';
  }
}
