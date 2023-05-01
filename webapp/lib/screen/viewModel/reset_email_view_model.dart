// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:webapp/screen/service/reset_email_service.dart';
import 'package:webapp/screen/view/reset_pin_view.dart';
import 'package:mobx/mobx.dart';

import 'package:webapp/core/base/base_view_model.dart';

import '../../core/network/model/response_model.dart';

part 'reset_email_view_model.g.dart';

class ResetEmailViewModel = _ResetEmailViewModelBase with _$ResetEmailViewModel;

abstract class _ResetEmailViewModelBase extends BaseViewModel with Store {
  BuildContext buildContext;
  final ResetEmailService resetEmailService;
  _ResetEmailViewModelBase(
    this.resetEmailService, {
    required this.buildContext,
  });

  late TextEditingController textEditingController;
  final formKeyReset = GlobalKey<FormState>();

  @override
  void init() {
    textEditingController = TextEditingController();
  }

  sendCode() async {
    if (formKeyReset.currentState!.validate()) {
      ResponseModel result =
          await resetEmailService.sendEmailInfo(textEditingController.text);
      if (!result.error!) {
        Navigator.pushReplacement(
            buildContext,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    ResetPinView(email: textEditingController.text)));
      } else {
        ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
            content: Text(
          result.description!,
          textAlign: TextAlign.center,
        )));
      }
    }
  }

  String? inputTextValidator(String? value) {
    if (value != null) if (value.isEmpty) return 'Bu değer boş olamaz.';
    return null;
  }
}
