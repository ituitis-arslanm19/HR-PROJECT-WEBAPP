// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../core/base/base_model.dart';

class AccessLocation extends BaseModel<AccessLocation> {
  int? id;
  String? name;
  int? type;
  String? siteName;
  String? location;

  AccessLocation({
    this.id,
    this.name,
    this.type,
    this.siteName,
    this.location,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'siteName': siteName,
      'location': location,
    };
  }

  @override
  AccessLocation fromJson(Map<String, dynamic> json) {
    return AccessLocation(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
      type: json['type'] != null ? json['type'] as int : null,
      siteName: json['siteName'] != null ? json['siteName'] as String : null,
      location: json['location'] != null ? json['location'] as String : null,
    );
  }

  DataGridRow toDataRow() => DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: id),
        DataGridCell<String>(columnName: 'name', value: name),
        DataGridCell<int>(columnName: 'designation', value: type),
        DataGridCell<String>(columnName: 'siteName', value: siteName),
        DataGridCell<String>(columnName: 'location', value: location),
      ]);
}
