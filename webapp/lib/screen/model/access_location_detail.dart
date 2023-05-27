import '../../core/base/base_model.dart';

class AccessLocationDetail extends BaseModel<AccessLocationDetail> {
  int? id;
  String? name;
  int? type;
  int? siteId;
  String? location;

  AccessLocationDetail(
      {this.id, this.name, this.type, this.siteId, this.location});

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'siteId': siteId,
      'location': location
    };
  }

  @override
  AccessLocationDetail fromJson(Map<String, dynamic> json) {
    return AccessLocationDetail(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
      type: json['type'] != null ? json['type'] as int : null,
      siteId: json['siteId'] != null ? json['siteId'] as int : null,
      location: json['location'] != null ? json['location'] as String : null,
    );
  }
}
