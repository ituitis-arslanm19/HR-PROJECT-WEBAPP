import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:webapp/core/base/data_grid_model.dart';

import '../../core/base/base_model.dart';

class Department extends BaseModel<Department> with DataGridModel{
  int? id;
  String? name;
  String? managerName;

  Department({
    this.id,
    this.name,
    this.managerName,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'managerName': managerName,
    };
  }

  @override
  Department fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
      managerName:
          json['managerName'] != null ? json['managerName'] as String : null,
    );
  }

  @override
  DataGridRow toDataGridRow() => DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: id),
        DataGridCell<String>(columnName: 'name', value: name),
        DataGridCell<String>(columnName: 'managerName', value: managerName)
      ]);
}
