// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DepartmentViewModel on _DepartmentViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_DepartmentViewModelBase.dataState', context: context);

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

  late final _$departmentListAtom =
      Atom(name: '_DepartmentViewModelBase.departmentList', context: context);

  @override
  List<Department>? get departmentList {
    _$departmentListAtom.reportRead();
    return super.departmentList;
  }

  @override
  set departmentList(List<Department>? value) {
    _$departmentListAtom.reportWrite(value, super.departmentList, () {
      super.departmentList = value;
    });
  }

  late final _$departmentsAtom =
      Atom(name: '_DepartmentViewModelBase.departments', context: context);

  @override
  List<Department>? get departments {
    _$departmentsAtom.reportRead();
    return super.departments;
  }

  @override
  set departments(List<Department>? value) {
    _$departmentsAtom.reportWrite(value, super.departments, () {
      super.departments = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_DepartmentViewModelBase.init', context: context);

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$_DepartmentViewModelBaseActionController =
      ActionController(name: '_DepartmentViewModelBase', context: context);

  @override
  dynamic filter(dynamic name) {
    final _$actionInfo = _$_DepartmentViewModelBaseActionController.startAction(
        name: '_DepartmentViewModelBase.filter');
    try {
      return super.filter(name);
    } finally {
      _$_DepartmentViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
departmentList: ${departmentList},
departments: ${departments}
    ''';
  }
}
