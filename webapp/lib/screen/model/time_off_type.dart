// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:webapp/core/base/base_model.dart';
import 'package:webapp/core/base/data_grid_model.dart';

class TimeOffType extends BaseModel<TimeOffType> with DataGridModel {
  int? id;
  String? name;
  String? description;
  int? numOfTimeOffDay;
  TimeOffType({
    this.id,
    this.name,
    this.description,
    this.numOfTimeOffDay
  });

  @override
  TimeOffType fromJson(Map<String, dynamic> json) {
    return TimeOffType(
        id: json['id'], name: json['name'], description: json['description'], numOfTimeOffDay: json['numOfTimeOffDay']);
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'numOfTimeOffDay': numOfTimeOffDay
    };
  }

  @override
  DataGridRow toDataGridRow() => DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: id),
        DataGridCell<String>(columnName: 'name', value: name),
        DataGridCell<String>(columnName: 'description', value: description),
        DataGridCell<int>(columnName: 'numOfTimeOffDay', value: numOfTimeOffDay)
      ]);
}
