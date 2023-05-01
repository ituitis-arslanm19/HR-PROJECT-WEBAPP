// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/base/base_model.dart';

class ResponseModel<T> {
  T? data;
  String? date;
  String? description;
  String? responseCode;
  bool? error;

  ResponseModel({
    this.data,
    this.date,
    this.description,
    this.responseCode,
    this.error,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'description': description,
      'responseCode': responseCode,
      'isError': error,
    };
  }

  ResponseModel<T> fromJson(Map<dynamic, dynamic> map) {
    return ResponseModel<T>(
      date: map['date'] != null ? map['date'].toString() : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      responseCode:
          map['responseCode'] != null ? map['responseCode'] as String : null,
      error: map['error'] != null ? map['error'] as bool : null,
    );
  }
}
