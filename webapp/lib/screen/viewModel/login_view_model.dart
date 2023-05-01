// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:webapp/core/base/base_view_model.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/screen/service/login_service.dart';
import 'package:webapp/screen/view/reset_email_view.dart';
import 'package:mobx/mobx.dart';

import '../../core/network/model/response_model.dart';
import '../model/employee.dart';
import '../view/main_view.dart';
part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase extends BaseViewModel with Store {
  final LoginService loginService;
  final BuildContext buildContext;
  late List<TextEditingController> controllers;
  final formKeyLogin = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();

  @observable
  DataState dataState = DataState.READY;

  _LoginViewModelBase(this.loginService, this.buildContext);

  @override
  @action
  init() {
    controllers = List.generate(5, (i) => TextEditingController());
  }

  @action
  login() async {
    if (formKeyLogin.currentState!.validate()) {
      dataState = DataState.LOADING;
      ResponseModel<Employee?> result = await loginService.login(
          controllers.elementAt(3).text, controllers.elementAt(4).text);

      if (result.data != null && !result.error!) {
        Navigator.pushReplacement(
            buildContext,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    MainView(clientType: result.data!.clientType!)));
      } else {
        dataState = DataState.ERROR;
        ScaffoldMessenger.of(buildContext).showSnackBar(const SnackBar(
            content: Text(
          "Lütfen kullanıcı adını ve şifreyi kontrol ediniz.",
          textAlign: TextAlign.center,
        )));
      }
    }
  }

  @action
  register() async {
    if (formKeyRegister.currentState!.validate()) {
      dataState = DataState.LOADING;
      ResponseModel result = await loginService.register(
          controllers.elementAt(0).text, controllers.elementAt(1).text);

      if (result.error!) {
        dataState = DataState.ERROR;
      }
      ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
          content: Text(
        result.description!,
        textAlign: TextAlign.center,
      )));
    }
  }

  navigateToForgotPassword() {
    Navigator.push(buildContext,
        MaterialPageRoute(builder: (BuildContext context) => ResetEmailView()));
  }

  String? inputTextValidator(String? value) {
    if (value != null) if (value.isEmpty) return 'Bu değer boş olamaz.';
    return null;
  }

  String? confirmPassValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) return 'Bu değer boş olamaz.';
      if (value != controllers[1].text) return 'Şifreler eşleşmiyor.';
    }
    return null;
  }
}
