// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_off_type_detail_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TimeOffTypeDetailViewModel on _TimeOffTypeDetailViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_TimeOffTypeDetailViewModelBase.dataState', context: context);

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

  late final _$timeOffTypeAtom = Atom(
      name: '_TimeOffTypeDetailViewModelBase.timeOffType', context: context);

  @override
  TimeOffType? get timeOffType {
    _$timeOffTypeAtom.reportRead();
    return super.timeOffType;
  }

  @override
  set timeOffType(TimeOffType? value) {
    _$timeOffTypeAtom.reportWrite(value, super.timeOffType, () {
      super.timeOffType = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_TimeOffTypeDetailViewModelBase.init', context: context);

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$updateTimeOffTypeAsyncAction = AsyncAction(
      '_TimeOffTypeDetailViewModelBase.updateTimeOffType',
      context: context);

  @override
  Future<bool> updateTimeOffType() {
    return _$updateTimeOffTypeAsyncAction.run(() => super.updateTimeOffType());
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
timeOffType: ${timeOffType}
    ''';
  }
}
