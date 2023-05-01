// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_pin_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ResetPinViewModel on _ResetPinViewModelBase, Store {
  late final _$countDownAtom =
      Atom(name: '_ResetPinViewModelBase.countDown', context: context);

  @override
  int get countDown {
    _$countDownAtom.reportRead();
    return super.countDown;
  }

  @override
  set countDown(int value) {
    _$countDownAtom.reportWrite(value, super.countDown, () {
      super.countDown = value;
    });
  }

  late final _$_ResetPinViewModelBaseActionController =
      ActionController(name: '_ResetPinViewModelBase', context: context);

  @override
  void setCountDown() {
    final _$actionInfo = _$_ResetPinViewModelBaseActionController.startAction(
        name: '_ResetPinViewModelBase.setCountDown');
    try {
      return super.setCountDown();
    } finally {
      _$_ResetPinViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void endCountDown() {
    final _$actionInfo = _$_ResetPinViewModelBaseActionController.startAction(
        name: '_ResetPinViewModelBase.endCountDown');
    try {
      return super.endCountDown();
    } finally {
      _$_ResetPinViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
countDown: ${countDown}
    ''';
  }
}
