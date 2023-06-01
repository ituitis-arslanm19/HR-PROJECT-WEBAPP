// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_info_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EmployeeInfoViewModel on _EmployeeInfoViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_EmployeeInfoViewModelBase.dataState', context: context);

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

  late final _$employeeInfoAtom =
      Atom(name: '_EmployeeInfoViewModelBase.employeeInfo', context: context);

  @override
  EmployeeInfo? get employeeInfo {
    _$employeeInfoAtom.reportRead();
    return super.employeeInfo;
  }

  @override
  set employeeInfo(EmployeeInfo? value) {
    _$employeeInfoAtom.reportWrite(value, super.employeeInfo, () {
      super.employeeInfo = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_EmployeeInfoViewModelBase.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
employeeInfo: ${employeeInfo}
    ''';
  }
}
