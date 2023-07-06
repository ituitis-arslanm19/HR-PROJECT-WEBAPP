// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../core/base/base_model.dart';
import '../../core/base/data_grid_model.dart';

class Asset extends BaseModel<Asset> with DataGridModel{
  int? id;
  String? name;
  String? description;
  String? dateOfIssue;

  Asset({
    this.id,
    this.name,
    this.description,
    this.dateOfIssue,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'dateOfIssue': dateOfIssue,
    };
  }

  @override
  Asset fromJson(Map<String, dynamic> map) {
    return Asset(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        description:
            map['description'] != null ? map['description'] as String : "",
        dateOfIssue:
            map['dateOfIssue'] != null ? map['dateOfIssue'] as String : "");
  }

  @override
  DataGridRow toDataGridRow() => DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: id),
        DataGridCell<String>(columnName: 'name', value: name),
        DataGridCell<String>(columnName: 'dateOfIssue', value: dateOfIssue)
      ]);
}
