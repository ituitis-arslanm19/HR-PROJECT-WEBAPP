// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:webapp/core/base/base_model.dart';

class Product extends BaseModel<Product> {
  String? name;
  String? dateOfIssue;
  String? description;

  Product({
    this.name,
    this.dateOfIssue,
    this.description,
  });

  @override
  Product fromJson(Map<String, dynamic> json) {
    return Product(
        name: json['name'],
        dateOfIssue: json['dateOfIssue'],
        description: json['description']);
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'dateOfIssue': dateOfIssue,
      'description': description
    };
  }

  @override
  String toString() =>
      'Product(name: $name, dateOfIssue: $dateOfIssue, description: $description)';
}
