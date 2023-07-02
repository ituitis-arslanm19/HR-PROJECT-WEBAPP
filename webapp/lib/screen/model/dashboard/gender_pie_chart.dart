import 'package:webapp/core/base/base_model.dart';

class GenderPieChart extends BaseModel<GenderPieChart> {
  int? maleEmployeeNum;
  int? femaleEmployeeNum;
  GenderPieChart({
    this.maleEmployeeNum,
    this.femaleEmployeeNum,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'maleEmployeeNum': maleEmployeeNum,
      'femaleEmployeeNum': femaleEmployeeNum,
    };
  }

  @override
  GenderPieChart fromJson(Map<String, dynamic> json) {
    return GenderPieChart(
        maleEmployeeNum: json['maleEmployeeNum'] as int,
        femaleEmployeeNum: json['femaleEmployeeNum'] as int);
  }
}
