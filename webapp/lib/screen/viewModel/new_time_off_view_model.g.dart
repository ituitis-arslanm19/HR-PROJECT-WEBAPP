// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_time_off_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NewTimeOffViewModel on _NewTimeOffViewModelBase, Store {
  late final _$timeOffTypeListAtom =
      Atom(name: '_NewTimeOffViewModelBase.timeOffTypeList', context: context);

  @override
  ObservableList<TimeOffType>? get timeOffTypeList {
    _$timeOffTypeListAtom.reportRead();
    return super.timeOffTypeList;
  }

  @override
  set timeOffTypeList(ObservableList<TimeOffType>? value) {
    _$timeOffTypeListAtom.reportWrite(value, super.timeOffTypeList, () {
      super.timeOffTypeList = value;
    });
  }

  late final _$dataStateAtom =
      Atom(name: '_NewTimeOffViewModelBase.dataState', context: context);

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

  late final _$descriptionAtom =
      Atom(name: '_NewTimeOffViewModelBase.description', context: context);

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
      Atom(name: '_NewTimeOffViewModelBase.selectedDate', context: context);

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

  late final _$timeOffTypeSelectedAtom = Atom(
      name: '_NewTimeOffViewModelBase.timeOffTypeSelected', context: context);

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
      AsyncAction('_NewTimeOffViewModelBase.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$_NewTimeOffViewModelBaseActionController =
      ActionController(name: '_NewTimeOffViewModelBase', context: context);

  @override
  dynamic changeTimeOffTypeSelected() {
    final _$actionInfo = _$_NewTimeOffViewModelBaseActionController.startAction(
        name: '_NewTimeOffViewModelBase.changeTimeOffTypeSelected');
    try {
      return super.changeTimeOffTypeSelected();
    } finally {
      _$_NewTimeOffViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
timeOffTypeList: ${timeOffTypeList},
dataState: ${dataState},
description: ${description},
selectedDate: ${selectedDate},
timeOffTypeSelected: ${timeOffTypeSelected}
    ''';
  }
}
