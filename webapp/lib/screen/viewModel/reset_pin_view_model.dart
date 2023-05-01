import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webapp/core/base/base_view_model.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/screen/model/password_change_token.dart';
import 'package:webapp/screen/model/request/get_password_change_token_request.dart';
import 'package:webapp/screen/service/reset_pin_service.dart';
import 'package:webapp/screen/view/reset_email_view.dart';
import 'package:webapp/screen/view/reset_password_view.dart';
import 'package:mobx/mobx.dart';

import '../../core/network/model/response_model.dart';
part 'reset_pin_view_model.g.dart';

class ResetPinViewModel = _ResetPinViewModelBase with _$ResetPinViewModel;

abstract class _ResetPinViewModelBase extends BaseViewModel with Store {
  final BuildContext buildContext;
  final ResetPinService resetPinService;
  final SecureStorage secureStorage;
  late List<TextEditingController> controllers;

  _ResetPinViewModelBase(
      this.buildContext, this.resetPinService, this.secureStorage);

  @observable
  int countDown = 180;

  Timer? countdownTimer;

  @override
  void init() {
    controllers = List.generate(4, (i) => TextEditingController());

    countDown = 180;
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  @action
  void setCountDown() {
    countDown -= 1;
    if (countDown <= 0) {
      endCountDown();
    }
  }

  @action
  void endCountDown() {
    if (countdownTimer != null) countdownTimer!.cancel();
    Navigator.pushReplacement(buildContext,
        MaterialPageRoute(builder: (BuildContext context) => ResetEmailView()));
  }

  checkCode(
    String email,
  ) async {
    GetPasswordChangeTokenRequest getPasswordChangeTokenRequest =
        GetPasswordChangeTokenRequest(email: email, code: _getText());
    ResponseModel<PasswordChangeToken?> result = await resetPinService
        .getPasswordChangeToken(getPasswordChangeTokenRequest);

    if ((!result.error!) && result.data != null && result.data!.token != null) {
      await secureStorage.writeSecureData(
          "passwordChangeToken", result.data!.token!);
      Navigator.pushReplacement(
          buildContext,
          MaterialPageRoute(
              builder: (BuildContext context) => ResetPasswordView()));
    } else {
      ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
          content: Text(
        result.description!,
        textAlign: TextAlign.center,
      )));
    }
  }

  String _getText() {
    String finalText = controllers[0].text +
        controllers[1].text +
        controllers[2].text +
        controllers[3].text;
    return finalText;
  }
}
