// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/base/base_model.dart';

class GenderPieChart extends BaseModel<GenderPieChart> {
  int? maleMobileClientNum;
  int? femaleMobileClientNum;
  GenderPieChart({
    this.maleMobileClientNum,
    this.femaleMobileClientNum,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'maleMobileClientNum': maleMobileClientNum,
      'femaleMobileClientNum': femaleMobileClientNum,
    };
  }

  @override
  GenderPieChart fromJson(Map<String, dynamic> json) {
    return GenderPieChart(
      maleMobileClientNum: json['maleMobileClientNum'] != null
          ? json['maleMobileClientNum'] as int
          : null,
      femaleMobileClientNum: json['femaleMobileClientNum'] != null
          ? json['femaleMobileClientNum'] as int
          : null,
    );
  }
}
