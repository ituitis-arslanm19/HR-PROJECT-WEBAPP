import 'package:webapp/core/base/base_view_model.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/screen/model/profile.dart';
import 'package:webapp/screen/service/profile_service.dart';
import 'package:mobx/mobx.dart';

import '../../core/network/model/response_model.dart';
part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase extends BaseViewModel with Store {
  final ProfileService profileService;

  @observable
  Profile? profile;

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  String? errorDescription;

  @action
  @override
  Future<void> init() async {
    ResponseModel<Profile?> result = await profileService.getProfile();
    if ((!result.error!) || result.data != null) {
      profile = result.data;
      dataState = DataState.READY;
    } else {
      errorDescription = result.description;
      dataState = DataState.ERROR;
    }
  }

  _ProfileViewModelBase(this.profileService);
}
