// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/constant/strings.dart';
import 'package:webapp/core/network/model/response_model.dart';
import 'package:webapp/core/network/network_manager.dart';

import '../model/profile.dart';

class ProfileService {
  NetworkManager networkManager;
  ProfileService({
    required this.networkManager,
  });

  Future<ResponseModel<Profile?>> getProfile() async {
    ResponseModel<Profile> result = await networkManager.send<Profile, Profile>(
        "/profile", HttpMethod.GET, Profile(), null, TOKEN);
    return result;
  }
}
