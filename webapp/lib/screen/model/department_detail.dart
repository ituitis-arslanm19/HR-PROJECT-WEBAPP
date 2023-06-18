import '../../core/base/base_model.dart';

class DepartmentDetail extends BaseModel<DepartmentDetail> {
  int? id;
  String? name;
  int? managerId;
  List<int>? managersToSignIds;
  int? parentDepartmentId;

  DepartmentDetail(
      {this.id,
      this.name,
      this.managerId,
      this.managersToSignIds,
      this.parentDepartmentId});

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'managerId': managerId,
      'managersToSignIds': managersToSignIds!.map((x) => x).toList(),
      'parentDepartmentId': parentDepartmentId
    };
  }

  @override
  DepartmentDetail fromJson(Map<String, dynamic> json) {
    return DepartmentDetail(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
      managerId: json['managerId'] != null ? json['managerId'] as int : null,
      managersToSignIds: json['managersToSignIds'] != null
          ? List<int>.from(json['managersToSignIds'])
          : [],
      parentDepartmentId: json['parentDepartmentId'] != null
          ? json['parentDepartmentId'] as int
          : null,
    );
  }
}
