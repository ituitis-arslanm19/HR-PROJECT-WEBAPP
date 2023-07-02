import 'package:syncfusion_flutter_datagrid/src/datagrid_widget/sfdatagrid.dart';

import '../../core/base/base_model.dart';
import '../../core/base/data_grid_model.dart';

class Reader extends BaseModel<Reader> with DataGridModel {
  int? id;
  String? name;
  int? type;
  int? direction;

  Reader({
    this.id,
    this.name,
    this.type,
    this.direction,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'direction': direction,
    };
  }

  @override
  Reader fromJson(Map<String, dynamic> json) {
    return Reader(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
      type: json['type'] != null ? json['type'] as int : null,
      direction: json['direction'] != null ? json['direction'] as int : null,
    );
  }

  @override
  DataGridRow toDataGridRow() => DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: id),
        DataGridCell<String>(columnName: 'name', value: name),
        DataGridCell<int>(columnName: 'type', value: type),
        DataGridCell<int>(columnName: 'direction', value: direction),
      ]);
}
