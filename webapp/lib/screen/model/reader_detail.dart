import '../../core/base/base_model.dart';

class ReaderDetail extends BaseModel<ReaderDetail> {
  int? id;
  String? name;
  int? type;
  int? direction;
  int? accessLocationId;

  ReaderDetail({
    this.id,
    this.name,
    this.type,
    this.direction,
    this.accessLocationId,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'direction': direction,
      'accessLocationId': accessLocationId,
    };
  }

  @override
  ReaderDetail fromJson(Map<String, dynamic> json) {
    return ReaderDetail(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
      type: json['type'] != null ? json['type'] as int : null,
      direction: json['direction'] != null ? json['direction'] as int : null,
      accessLocationId: json['accessLocationId'] != null
          ? json['accessLocationId'] as int
          : null,
    );
  }
}
