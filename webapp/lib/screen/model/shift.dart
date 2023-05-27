import '../../core/base/base_model.dart';

class Shift extends BaseModel<Shift> {
  int? id;
  String? name;
  String? startTime;
  String? endTime;

  Shift({this.id, this.name, this.startTime, this.endTime});

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'startTime': startTime,
      'endTime': endTime
    };
  }

  @override
  Shift fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
      startTime: json['startTime'] != null ? json['startTime'] as String : null,
      endTime: json['endTime'] != null ? json['endTime'] as String : null,
    );
  }
}
