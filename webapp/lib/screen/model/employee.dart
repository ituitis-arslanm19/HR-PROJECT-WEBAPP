import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:webapp/core/base/data_grid_model.dart';

import '../../core/base/base_model.dart';

class Employee extends BaseModel<Employee> with DataGridModel{
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

  @override
  DataGridRow toDataGridRow() => DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: id),
        DataGridCell<String>(columnName: 'firstName', value: firstName),
        DataGridCell<String>(columnName: 'lastName', value: lastName),
        DataGridCell<String>(columnName: 'email', value: email),
        DataGridCell<String>(columnName: 'deparmantName', value: departmentName)
      ]);
}
