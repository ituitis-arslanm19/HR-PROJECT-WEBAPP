// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:webapp/core/constant/enum/enums.dart';

import '../../../core/base/base_model.dart';

class UpdateAssetStatusRequest extends BaseModel<UpdateAssetStatusRequest> {
  int? id;
  ProductStatus? status;

  UpdateAssetStatusRequest({
    this.status,
    this.id,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'status': status == ProductStatus.RETURNED ? "RETURNED" : "NOT_RETURNED"
    };
  }

  @override
  UpdateAssetStatusRequest fromJson(Map<String, dynamic> json) {
    return UpdateAssetStatusRequest(
      status: json['status'] == "NOT_RETURNED"
          ? ProductStatus.NOT_RETURNED
          : json['status'] == "RETURNED"
              ? ProductStatus.RETURNED
              : ProductStatus.AT_EMPLOYEE,
      id: json['id'] != null ? json['id'] as int : null,
    );
  }
}
