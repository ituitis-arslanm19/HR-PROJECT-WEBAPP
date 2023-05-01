// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:webapp/core/base/base_model.dart';

class QrCode extends BaseModel<QrCode> {
  String? data;
  int? remainingTime;
  QrCode({this.data, this.remainingTime});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'data': data, 'remainingTime': remainingTime};
  }

  @override
  String toString() => 'QrCode(data: $data)';

  @override
  QrCode fromJson(Map<String, dynamic> json) {
    return QrCode(data: json['data'], remainingTime: json['remainingTime']);
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'data': data, 'remainingTime': remainingTime};
  }
}
