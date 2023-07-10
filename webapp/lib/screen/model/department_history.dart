import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:webapp/core/base/data_grid_model.dart';

import '../../core/base/base_model.dart';

class DepartmentHistory extends BaseModel<DepartmentHistory>
    with DataGridModel {
  int? id;
  String? departmentName;
  String? positionName;
  String? shiftName;
  int? shiftId;
  String? startDate;
  String? endDate;

  DepartmentHistory(
      {this.id,
      this.departmentName,
      this.positionName,
      this.shiftName,
      this.shiftId,
      this.startDate,
      this.endDate});

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'departmentName': departmentName,
      'positionName': positionName,
      'shiftName': shiftName,
      'shiftId': shiftId,
      'startDate': startDate,
      'endDate': endDate
    };
  }

  @override
  DepartmentHistory fromJson(Map<String, dynamic> json) {
    return DepartmentHistory(
        id: json['id'] != null ? json['id'] as int : null,
        departmentName: json['departmentName'] != null
            ? json['departmentName'] as String
            : null,
        positionName:
            json['positionName'] != null ? json['positionName'] as String : "",
        shiftName: json['shiftName'] != null ? json['shiftName'] as String : "",
        shiftId: json['shiftId'] != null ? json['shiftId'] as int : null,
        startDate:
            json['startDate'] != null ? json['startDate'] as String : null,
        endDate: json['endDate'] != null ? json['endDate'] as String : null);
  }

  @override
  DataGridRow toDataGridRow() => DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: id),
        DataGridCell<String>(
            columnName: 'departmentName', value: departmentName),
        DataGridCell<String>(columnName: 'positionName', value: positionName),
        DataGridCell<String>(columnName: "shiftName", value: shiftName),
        DataGridCell<DateTime>(
            columnName: 'startDate',
            value: DateFormat("dd/MM/yyyy").parse(startDate ?? "00/00/0000")),
        DataGridCell<DateTime>(
            columnName: 'endDate',
            value: DateFormat("dd/MM/yyyy").parse(endDate ?? "00/00/0000")),
      ]);
}
