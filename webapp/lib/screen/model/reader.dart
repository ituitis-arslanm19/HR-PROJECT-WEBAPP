import '../../core/base/base_model.dart';

class Reader extends BaseModel<Reader> {
  int? id;
  String? name;
  int? type;
  int? direction;

  Reader({
    this.id,
    this.name,
    this.type,
    this.direction,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'direction': direction,
    };
  }

  @override
  Reader fromJson(Map<String, dynamic> json) {
    return Reader(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
      type: json['type'] != null ? json['type'] as int : null,
      direction: json['direction'] != null ? json['direction'] as int : null,
    );
  }
}
