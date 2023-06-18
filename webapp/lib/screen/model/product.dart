// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:webapp/core/base/base_model.dart';
import 'package:webapp/core/constant/enum/enums.dart';

class Product extends BaseModel<Product> {
  String? name;
  String? dateOfIssue;
  String? description;
  ProductType? type;

  Product({
    this.name,
    this.dateOfIssue,
    this.description,
    this.type,
  });

  @override
  Product fromJson(Map<String, dynamic> json) {
    ProductType productType;

    switch (json["type"]) {
      case "HEADPHONE":
        productType = ProductType.HEADPHONE;
        break;
      case "KEYBOARD":
        productType = ProductType.KEYBOARD;
        break;
      case "MOUSE":
        productType = ProductType.MOUSE;
        break;
      case "OTHER":
        productType = ProductType.OTHER;
        break;
      default:
        productType = ProductType.LAPTOP;
    }
    return Product(
        name: json['name'],
        dateOfIssue: json['dateOfIssue'],
        description: json['description'],
        type: productType);
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'dateOfIssue': dateOfIssue,
      'description': description,
      'type': type.toString()
    };
  }

  @override
  String toString() {
    return 'Product(name: $name, dateOfIssue: $dateOfIssue, description: $description, type: $type)';
  }
}
