// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_off_type_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TimeOffTypeViewModel on _TimeOffTypeViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_TimeOffTypeViewModelBase.dataState', context: context);

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

  late final _$timeOffTypeListAtom =
      Atom(name: '_TimeOffTypeViewModelBase.timeOffTypeList', context: context);

  @override
  List<TimeOffType>? get timeOffTypeList {
    _$timeOffTypeListAtom.reportRead();
    return super.timeOffTypeList;
  }

  @override
  set timeOffTypeList(List<TimeOffType>? value) {
    _$timeOffTypeListAtom.reportWrite(value, super.timeOffTypeList, () {
      super.timeOffTypeList = value;
    });
  }

  late final _$timeOffTypesAtom =
      Atom(name: '_TimeOffTypeViewModelBase.timeOffTypes', context: context);

  @override
  List<TimeOffType>? get timeOffTypes {
    _$timeOffTypesAtom.reportRead();
    return super.timeOffTypes;
  }

  @override
  set timeOffTypes(List<TimeOffType>? value) {
    _$timeOffTypesAtom.reportWrite(value, super.timeOffTypes, () {
      super.timeOffTypes = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_TimeOffTypeViewModelBase.init', context: context);

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$deleteAsyncAction =
      AsyncAction('_TimeOffTypeViewModelBase.delete', context: context);

  @override
  Future delete(int id) {
    return _$deleteAsyncAction.run(() => super.delete(id));
  }

  late final _$_TimeOffTypeViewModelBaseActionController =
      ActionController(name: '_TimeOffTypeViewModelBase', context: context);

  @override
  dynamic filter(dynamic name) {
    final _$actionInfo = _$_TimeOffTypeViewModelBaseActionController
        .startAction(name: '_TimeOffTypeViewModelBase.filter');
    try {
      return super.filter(name);
    } finally {
      _$_TimeOffTypeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
timeOffTypeList: ${timeOffTypeList},
timeOffTypes: ${timeOffTypes}
    ''';
  }
}
