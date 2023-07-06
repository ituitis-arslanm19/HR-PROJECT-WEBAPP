import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:webapp/core/base/data_grid_model.dart';

import '../../core/base/base_model.dart';

class Site extends BaseModel<Site> with DataGridModel{
  int? id;
  String? name;

  Site({
    this.id,
    this.name,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  @override
  Site fromJson(Map<String, dynamic> json) {
    return Site(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
    );
  }

  @override
  bool operator ==(covariant Site other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  DataGridRow toDataGridRow() => DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: id),
        DataGridCell<String>(columnName: 'name', value: name)
      ]);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
