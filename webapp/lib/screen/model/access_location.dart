// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../core/base/base_model.dart';

class AccessLocation extends BaseModel<AccessLocation> {
  int? id;
  String? name;
  int? type;
  String? siteName;

  AccessLocation({this.id, this.name, this.type, this.siteName});

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'siteName': siteName,
    };
  }

  @override
  AccessLocation fromJson(Map<String, dynamic> json) {
    return AccessLocation(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
      type: json['type'] != null ? json['type'] as int : null,
      siteName: json['siteName'] != null ? json['siteName'] as String : null,
    );
  }
}
