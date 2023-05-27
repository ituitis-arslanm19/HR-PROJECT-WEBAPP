// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../core/base/base_model.dart';

class Asset extends BaseModel<Asset> {
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
}
