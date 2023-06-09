// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:webapp/core/base/base_model.dart';
import 'package:webapp/screen/model/asset_type.dart';

class Product extends BaseModel<Product> {
  String? name;
  String? dateOfIssue;
  String? description;
  AssetType? type;

  Product({
    this.name,
    this.dateOfIssue,
    this.description,
    this.type,
  });

  @override
  Product fromJson(Map<String, dynamic> json) {
    return Product(
        name: json['name'],
        dateOfIssue: json['dateOfIssue'],
        description: json['description'],
        type: AssetType().fromJson(json["type"]));
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'dateOfIssue': dateOfIssue,
      'description': description,
      'type': type?.toJson()
    };
  }

  @override
  String toString() {
    return 'Product(name: $name, dateOfIssue: $dateOfIssue, description: $description, type: $type)';
  }
}
