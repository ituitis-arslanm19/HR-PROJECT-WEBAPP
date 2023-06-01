// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_info_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DepartmentInfoViewModel on _DepartmentInfoViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_DepartmentInfoViewModelBase.dataState', context: context);

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

  late final _$departmentInfoAtom = Atom(
      name: '_DepartmentInfoViewModelBase.departmentInfo', context: context);

  @override
  DepartmentInfo? get departmentInfo {
    _$departmentInfoAtom.reportRead();
    return super.departmentInfo;
  }

  @override
  set departmentInfo(DepartmentInfo? value) {
    _$departmentInfoAtom.reportWrite(value, super.departmentInfo, () {
      super.departmentInfo = value;
    });
  }

  late final _$pieChartIndexAtom = Atom(
      name: '_DepartmentInfoViewModelBase.pieChartIndex', context: context);

  @override
  int? get pieChartIndex {
    _$pieChartIndexAtom.reportRead();
    return super.pieChartIndex;
  }

  @override
  set pieChartIndex(int? value) {
    _$pieChartIndexAtom.reportWrite(value, super.pieChartIndex, () {
      super.pieChartIndex = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_DepartmentInfoViewModelBase.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$_DepartmentInfoViewModelBaseActionController =
      ActionController(name: '_DepartmentInfoViewModelBase', context: context);

  @override
  dynamic changePieChartIndex(int value) {
    final _$actionInfo = _$_DepartmentInfoViewModelBaseActionController
        .startAction(name: '_DepartmentInfoViewModelBase.changePieChartIndex');
    try {
      return super.changePieChartIndex(value);
    } finally {
      _$_DepartmentInfoViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
departmentInfo: ${departmentInfo},
pieChartIndex: ${pieChartIndex}
    ''';
  }
}
