import 'package:webapp/core/base/base_model.dart';
import 'package:webapp/core/constant/enum/enums.dart';

class MobileClient extends BaseModel<MobileClient> {
  String? accessToken;
  String? refreshToken;
  List<ClientType>? roles;
  MobileClient({this.accessToken, this.refreshToken, this.roles});

  @override
  MobileClient fromJson(Map<String, dynamic> json) {
    return MobileClient(
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
        roles: List<ClientType>.from(json['roles'].map((e) {
          switch (e) {
            case "EMPLOYEE":
              return ClientType.EMPLOYEE;
            case "MANAGER":
              return ClientType.MANAGER;
            case "HR":
              return ClientType.HR;
            case "ADMIN":
              return ClientType.ADMIN;
            default:
              return ClientType.EMPLOYEE;
          }
        }).toList()));
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'roles': roles != null ? roles!.map((x) => x.toString()).toList() : [],
    };
  }
}
