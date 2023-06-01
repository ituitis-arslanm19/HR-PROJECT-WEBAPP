// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_off_sign_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TimeOffSignViewModel on _TimeOffSignViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_TimeOffSignViewModelBase.dataState', context: context);

  @override
  DataState get dataState {
    _$dataStateAtom.reportRead();
    return super.dataState;
  }

  @override
  set dataState(DataState value) {
    _$dataStateAtom.reportWrite(value, super.dataState, () {
      super.dataState = value;
    });
  }

  late final _$timeOffListAtom =
      Atom(name: '_TimeOffSignViewModelBase.timeOffList', context: context);

  @override
  List<TimeOffSign>? get timeOffList {
    _$timeOffListAtom.reportRead();
    return super.timeOffList;
  }

  @override
  set timeOffList(List<TimeOffSign>? value) {
    _$timeOffListAtom.reportWrite(value, super.timeOffList, () {
      super.timeOffList = value;
    });
  }

  late final _$timeOffsAtom =
      Atom(name: '_TimeOffSignViewModelBase.timeOffs', context: context);

  @override
  List<TimeOffSign>? get timeOffs {
    _$timeOffsAtom.reportRead();
    return super.timeOffs;
  }

  @override
  set timeOffs(List<TimeOffSign>? value) {
    _$timeOffsAtom.reportWrite(value, super.timeOffs, () {
      super.timeOffs = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_TimeOffSignViewModelBase.init', context: context);

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$signTimeOffSignAsyncAction = AsyncAction(
      '_TimeOffSignViewModelBase.signTimeOffSign',
      context: context);

  @override
  Future<bool> signTimeOffSign(int id) {
    return _$signTimeOffSignAsyncAction.run(() => super.signTimeOffSign(id));
  }

  late final _$printTimeOffAsyncAction =
      AsyncAction('_TimeOffSignViewModelBase.printTimeOff', context: context);

  @override
  Future<Uint8List?> printTimeOff(int id) {
    return _$printTimeOffAsyncAction.run(() => super.printTimeOff(id));
  }

  late final _$_TimeOffSignViewModelBaseActionController =
      ActionController(name: '_TimeOffSignViewModelBase', context: context);

  @override
  dynamic filter(dynamic name) {
    final _$actionInfo = _$_TimeOffSignViewModelBaseActionController
        .startAction(name: '_TimeOffSignViewModelBase.filter');
    try {
      return super.filter(name);
    } finally {
      _$_TimeOffSignViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
timeOffList: ${timeOffList},
timeOffs: ${timeOffs}
    ''';
  }
}
