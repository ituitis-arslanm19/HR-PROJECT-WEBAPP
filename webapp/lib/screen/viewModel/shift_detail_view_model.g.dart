// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_detail_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ShiftDetailViewModel on _ShiftDetailViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_ShiftDetailViewModelBase.dataState', context: context);

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

  late final _$shiftDetailAtom =
      Atom(name: '_ShiftDetailViewModelBase.shiftDetail', context: context);

  @override
  Shift? get shiftDetail {
    _$shiftDetailAtom.reportRead();
    return super.shiftDetail;
  }

  @override
  set shiftDetail(Shift? value) {
    _$shiftDetailAtom.reportWrite(value, super.shiftDetail, () {
      super.shiftDetail = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_ShiftDetailViewModelBase.init', context: context);

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$updateShiftAsyncAction =
      AsyncAction('_ShiftDetailViewModelBase.updateShift', context: context);

  @override
  Future updateShift() {
    return _$updateShiftAsyncAction.run(() => super.updateShift());
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
shiftDetail: ${shiftDetail}
    ''';
  }
}
