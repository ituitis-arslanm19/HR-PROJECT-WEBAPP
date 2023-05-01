// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:webapp/core/base/base_view_model.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/screen/view/login_view.dart';
import 'package:mobx/mobx.dart';
part 'main_view_model.g.dart';

class MainViewModel = _MainViewModelBase with _$MainViewModel;

abstract class _MainViewModelBase extends BaseViewModel with Store {
  final BuildContext buildContext;
  final SecureStorage secureStorage;

  @observable
  bool isLoading = true;

  @observable
  int bnbIndex = 0;

  _MainViewModelBase(this.buildContext, this.secureStorage);

  @override
  @action
  init() {
    isLoading = !isLoading;
  }

  @action
  setBnbIndex(int index) {
    bnbIndex = index;
  }

  logout() async {
    await secureStorage.deleteSecureData("refreshToken");
    await secureStorage.deleteSecureData("accessToken");

    Navigator.pushReplacement(buildContext,
        MaterialPageRoute(builder: (BuildContext context) => LoginView()));
  }
}
