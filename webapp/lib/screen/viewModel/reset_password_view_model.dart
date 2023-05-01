import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webapp/core/base/base_view_model.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/screen/model/request/update_password_request.dart';
import 'package:webapp/screen/service/reset_password_service.dart';
import 'package:webapp/screen/view/login_view.dart';
import 'package:mobx/mobx.dart';

import '../../core/network/model/response_model.dart';
part 'reset_password_view_model.g.dart';

class ResetPasswordViewModel = _ResetPasswordViewModelBase
    with _$ResetPasswordViewModel;

abstract class _ResetPasswordViewModelBase extends BaseViewModel with Store {
  final BuildContext buildContext;
  final ResetPasswordService resetPasswordService;
  late List<TextEditingController> controllers;
  final SecureStorage secureStorage;
  final formKeyReset = GlobalKey<FormState>();

  _ResetPasswordViewModelBase(
      this.buildContext, this.resetPasswordService, this.secureStorage);

  @override
  void init() {
    controllers = List.generate(2, (i) => TextEditingController());
  }

  String? inputTextValidator(String? value) {
    if (value != null) if (value.isEmpty) return 'Bu değer boş olamaz.';
    return null;
  }

  String? confirmPassValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) return 'Bu değer boş olamaz.';
      if (value != controllers[0].text) return 'Şifreler eşleşmiyor.';
    }
    return null;
  }

  updatePassword() async {
    if (formKeyReset.currentState!.validate()) {
      UpdatePasswordRequest updatePasswordRequest = UpdatePasswordRequest(
          password: controllers[0].text,
          token: await secureStorage.readSecureData("passwordChangeToken"));
      ResponseModel result =
          await resetPasswordService.updatePassword(updatePasswordRequest);
      ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
          content: Text(
        result.description!,
        textAlign: TextAlign.center,
      )));
      Navigator.pushReplacement(buildContext,
          MaterialPageRoute(builder: (BuildContext context) => LoginView()));
    }
  }
}
