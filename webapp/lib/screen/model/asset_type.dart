// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:webapp/core/base/base_model.dart';
import 'package:webapp/core/base/data_grid_model.dart';

class AssetType extends BaseModel<AssetType> with DataGridModel{
  int? id;
  String? name;
  AssetType({this.id, this.name});

  @override
  AssetType fromJson(Map<String, dynamic> json) {
    return AssetType(
        id: json['id'] != null ? json['id'] as int : null,
        name: json['name'] != null ? json['name'] as String : null);
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'name': name};
  }

  @override
  DataGridRow toDataGridRow() => DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: id),
        DataGridCell<String>(columnName: 'name', value: name)
      ]);
}
