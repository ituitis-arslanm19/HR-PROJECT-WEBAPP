// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ShiftViewModel on _ShiftViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_ShiftViewModelBase.dataState', context: context);

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

  late final _$shiftListAtom =
      Atom(name: '_ShiftViewModelBase.shiftList', context: context);

  @override
  List<Shift>? get shiftList {
    _$shiftListAtom.reportRead();
    return super.shiftList;
  }

  @override
  set shiftList(List<Shift>? value) {
    _$shiftListAtom.reportWrite(value, super.shiftList, () {
      super.shiftList = value;
    });
  }

  late final _$shiftsAtom =
      Atom(name: '_ShiftViewModelBase.shifts', context: context);

  @override
  List<Shift>? get shifts {
    _$shiftsAtom.reportRead();
    return super.shifts;
  }

  @override
  set shifts(List<Shift>? value) {
    _$shiftsAtom.reportWrite(value, super.shifts, () {
      super.shifts = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_ShiftViewModelBase.init', context: context);

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$_ShiftViewModelBaseActionController =
      ActionController(name: '_ShiftViewModelBase', context: context);

  @override
  dynamic filter(dynamic name) {
    final _$actionInfo = _$_ShiftViewModelBaseActionController.startAction(
        name: '_ShiftViewModelBase.filter');
    try {
      return super.filter(name);
    } finally {
      _$_ShiftViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
shiftList: ${shiftList},
shifts: ${shifts}
    ''';
  }
}
