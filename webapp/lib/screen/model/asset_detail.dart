// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/screen/model/asset_type.dart';

import '../../core/base/base_model.dart';

class AssetDetail extends BaseModel<AssetDetail> {
  int? id;
  String? name;
  String? description;
  String? dateOfIssue;
  int? employeeId;
  AssetType? type;
  ProductStatus? status;

  AssetDetail(
      {this.id,
      this.name,
      this.description,
      this.dateOfIssue,
      this.employeeId,
      this.type,
      this.status});

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'dateOfIssue': dateOfIssue,
      'employeeId': employeeId,
      'type': type?.toJson(),
      'status': status == ProductStatus.RETURNED ? "RETURNED" : "NOT_RETURNED"
    };
  }

  @override
  AssetDetail fromJson(Map<String, dynamic> json) {
    ProductStatus productStatus = ProductStatus.AT_EMPLOYEE;
    switch (json["status"]) {
      case "RETURNED":
        productStatus = ProductStatus.RETURNED;
        break;
      case "NOT_RETURNED":
        productStatus = ProductStatus.NOT_RETURNED;
        break;
    }
    return AssetDetail(
        id: json['id'] != null ? json['id'] as int : null,
        name: json['name'] != null ? json['name'] as String : null,
        description:
            json['description'] != null ? json['description'] as String : null,
        dateOfIssue:
            json['dateOfIssue'] != null ? json['dateOfIssue'] as String : null,
        employeeId:
            json['employeeId'] != null ? json['employeeId'] as int : null,
        type: json['employeeId'] != null
            ? AssetType().fromJson(json["type"])
            : null,
        status: productStatus);
  }
}
