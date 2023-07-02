// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:webapp/core/network/model/response_model.dart';
import 'package:webapp/screen/model/mobile_client.dart';
import 'package:webapp/screen/service/splash_service.dart';
import 'package:webapp/screen/view/login_view.dart';
import 'package:webapp/screen/view/main_view.dart';
import 'package:mobx/mobx.dart';
import 'package:webapp/core/base/base_view_model.dart';
import 'package:webapp/core/constant/enum/enums.dart';

part 'splash_view_model.g.dart';

class SplashViewModel = _SplashViewModelBase with _$SplashViewModel;

abstract class _SplashViewModelBase extends BaseViewModel with Store {
  DataState dataState = DataState.LOADING;

  final SplashService splashService;

  final BuildContext buildContext;

  _SplashViewModelBase(
    this.buildContext,
    this.splashService,
  );

  @override
  @action
  Future<void> init() async {
    ResponseModel<MobileClient?> result = await splashService.authenticate();

    if (!result.error! && result.data != null) {
      Navigator.pushReplacement(
          buildContext,
          MaterialPageRoute(
              builder: (BuildContext context) => MainView(
                    roles: result.data!.roles!,
                  )));
    } else {
      Navigator.pushReplacement(buildContext,
          MaterialPageRoute(builder: (BuildContext context) => LoginView()));
    }
  }
}
