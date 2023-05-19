// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_list_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DepartmentListViewModel on _DepartmentListViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_DepartmentListViewModelBase.dataState', context: context);

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

  late final _$departmentListAtom = Atom(
      name: '_DepartmentListViewModelBase.departmentList', context: context);

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

  late final _$initAsyncAction =
      AsyncAction('_DepartmentListViewModelBase.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
departmentList: ${departmentList}
    ''';
  }
}
