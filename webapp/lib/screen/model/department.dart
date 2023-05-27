import '../../core/base/base_model.dart';

class Department extends BaseModel<Department> {
  int? id;
  String? name;
  String? managerName;

  Department({
    this.id,
    this.name,
    this.managerName,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'managerName': managerName,
    };
  }

  @override
  Department fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
      managerName:
          json['managerName'] != null ? json['managerName'] as String : null,
    );
  }
}
