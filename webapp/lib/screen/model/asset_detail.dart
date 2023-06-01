// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../core/base/base_model.dart';

class AssetDetail extends BaseModel<AssetDetail> {
  int? id;
  String? name;
  String? description;
  String? dateOfIssue;
  int? employeeId;
  String? type;

  AssetDetail({
    this.id,
    this.name,
    this.description,
    this.dateOfIssue,
    this.employeeId,
    this.type
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'dateOfIssue': dateOfIssue,
      'employeeId': employeeId,
      'type': type,
    };
  }

  @override
  AssetDetail fromJson(Map<String, dynamic> json) {
    return AssetDetail(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
      description:
          json['description'] != null ? json['description'] as String : null,
      dateOfIssue:
          json['dateOfIssue'] != null ? json['dateOfIssue'] as String : null,
      employeeId: json['employeeId'] != null ? json['employeeId'] as int : null,
      type: json['type'] != null ? json['type'] as String : null,
    );
  }
}
