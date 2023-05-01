// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_off_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TimeOffViewModel on _TimeOffViewModelBase, Store {
  late final _$pendingTimeOffListAtom =
      Atom(name: '_TimeOffViewModelBase.pendingTimeOffList', context: context);

  @override
  ObservableList<TimeOff>? get pendingTimeOffList {
    _$pendingTimeOffListAtom.reportRead();
    return super.pendingTimeOffList;
  }

  @override
  set pendingTimeOffList(ObservableList<TimeOff>? value) {
    _$pendingTimeOffListAtom.reportWrite(value, super.pendingTimeOffList, () {
      super.pendingTimeOffList = value;
    });
  }

  late final _$previousTimeOffListAtom =
      Atom(name: '_TimeOffViewModelBase.previousTimeOffList', context: context);

  @override
  ObservableList<TimeOff>? get previousTimeOffList {
    _$previousTimeOffListAtom.reportRead();
    return super.previousTimeOffList;
  }

  @override
  set previousTimeOffList(ObservableList<TimeOff>? value) {
    _$previousTimeOffListAtom.reportWrite(value, super.previousTimeOffList, () {
      super.previousTimeOffList = value;
    });
  }

  late final _$dataState1Atom =
      Atom(name: '_TimeOffViewModelBase.dataState1', context: context);

  @override
  DataState get dataState1 {
    _$dataState1Atom.reportRead();
    return super.dataState1;
  }

  @override
  set dataState1(DataState value) {
    _$dataState1Atom.reportWrite(value, super.dataState1, () {
      super.dataState1 = value;
    });
  }

  late final _$dataState2Atom =
      Atom(name: '_TimeOffViewModelBase.dataState2', context: context);

  @override
  DataState get dataState2 {
    _$dataState2Atom.reportRead();
    return super.dataState2;
  }

  @override
  set dataState2(DataState value) {
    _$dataState2Atom.reportWrite(value, super.dataState2, () {
      super.dataState2 = value;
    });
  }

  late final _$descriptionAtom =
      Atom(name: '_TimeOffViewModelBase.description', context: context);

  @override
  String? get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String? value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$selectedDateAtom =
      Atom(name: '_TimeOffViewModelBase.selectedDate', context: context);

  @override
  DateTime get selectedDate {
    _$selectedDateAtom.reportRead();
    return super.selectedDate;
  }

  @override
  set selectedDate(DateTime value) {
    _$selectedDateAtom.reportWrite(value, super.selectedDate, () {
      super.selectedDate = value;
    });
  }

  late final _$timeOffTypeSelectedAtom =
      Atom(name: '_TimeOffViewModelBase.timeOffTypeSelected', context: context);

  @override
  bool get timeOffTypeSelected {
    _$timeOffTypeSelectedAtom.reportRead();
    return super.timeOffTypeSelected;
  }

  @override
  set timeOffTypeSelected(bool value) {
    _$timeOffTypeSelectedAtom.reportWrite(value, super.timeOffTypeSelected, () {
      super.timeOffTypeSelected = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_TimeOffViewModelBase.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$_TimeOffViewModelBaseActionController =
      ActionController(name: '_TimeOffViewModelBase', context: context);

  @override
  dynamic changeTimeOffTypeSelected() {
    final _$actionInfo = _$_TimeOffViewModelBaseActionController.startAction(
        name: '_TimeOffViewModelBase.changeTimeOffTypeSelected');
    try {
      return super.changeTimeOffTypeSelected();
    } finally {
      _$_TimeOffViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pendingTimeOffList: ${pendingTimeOffList},
previousTimeOffList: ${previousTimeOffList},
dataState1: ${dataState1},
dataState2: ${dataState2},
description: ${description},
selectedDate: ${selectedDate},
timeOffTypeSelected: ${timeOffTypeSelected}
    ''';
  }
}
