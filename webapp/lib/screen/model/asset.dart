// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:webapp/core/constant/enum/enums.dart';

import '../../core/base/base_model.dart';
import '../../core/base/data_grid_model.dart';

class Asset extends BaseModel<Asset> with DataGridModel {
  int? id;
  String? name;
  String? description;
  String? dateOfIssue;
  ProductStatus? status;

  Asset({this.id, this.name, this.description, this.dateOfIssue, this.status});

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'dateOfIssue': dateOfIssue,
      'status': status.toString()
    };
  }

  @override
  Asset fromJson(Map<String, dynamic> map) {
    ProductStatus productStatus = ProductStatus.AT_EMPLOYEE;
    switch (map["status"]) {
      case "RETURNED":
        productStatus = ProductStatus.RETURNED;
        break;
      case "NOT_RETURNED":
        productStatus = ProductStatus.NOT_RETURNED;
        break;
    }
    return Asset(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        description:
            map['description'] != null ? map['description'] as String : "",
        dateOfIssue:
            map['dateOfIssue'] != null ? map['dateOfIssue'] as String : "",
        status: productStatus);
  }

  @override
  DataGridRow toDataGridRow() => DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: id),
        DataGridCell<String>(columnName: 'name', value: name),
        DataGridCell<String>(columnName: 'dateOfIssue', value: dateOfIssue),
        DataGridCell<ProductStatus>(columnName: "status", value: status)
      ]);
}
