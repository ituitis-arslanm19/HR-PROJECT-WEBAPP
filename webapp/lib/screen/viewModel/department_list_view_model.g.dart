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
  List<DepartmentListItem>? get departmentList {
    _$departmentListAtom.reportRead();
    return super.departmentList;
  }

  @override
  set departmentList(List<DepartmentListItem>? value) {
    _$departmentListAtom.reportWrite(value, super.departmentList, () {
      super.departmentList = value;
    });
  }

  late final _$filteredDepartmanListAtom = Atom(
      name: '_DepartmentListViewModelBase.filteredDepartmanList',
      context: context);

  @override
  List<DepartmentListItem>? get filteredDepartmanList {
    _$filteredDepartmanListAtom.reportRead();
    return super.filteredDepartmanList;
  }

  @override
  set filteredDepartmanList(List<DepartmentListItem>? value) {
    _$filteredDepartmanListAtom.reportWrite(value, super.filteredDepartmanList,
        () {
      super.filteredDepartmanList = value;
    });
  }

  late final _$pageStateAtom =
      Atom(name: '_DepartmentListViewModelBase.pageState', context: context);

  @override
  int get pageState {
    _$pageStateAtom.reportRead();
    return super.pageState;
  }

  @override
  set pageState(int value) {
    _$pageStateAtom.reportWrite(value, super.pageState, () {
      super.pageState = value;
    });
  }

  late final _$selectedEmployeeIdAtom = Atom(
      name: '_DepartmentListViewModelBase.selectedEmployeeId',
      context: context);

  @override
  int get selectedEmployeeId {
    _$selectedEmployeeIdAtom.reportRead();
    return super.selectedEmployeeId;
  }

  @override
  set selectedEmployeeId(int value) {
    _$selectedEmployeeIdAtom.reportWrite(value, super.selectedEmployeeId, () {
      super.selectedEmployeeId = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_DepartmentListViewModelBase.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$_DepartmentListViewModelBaseActionController =
      ActionController(name: '_DepartmentListViewModelBase', context: context);

  @override
  dynamic changePageState(dynamic value) {
    final _$actionInfo = _$_DepartmentListViewModelBaseActionController
        .startAction(name: '_DepartmentListViewModelBase.changePageState');
    try {
      return super.changePageState(value);
    } finally {
      _$_DepartmentListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeSelectedEmployeeId(dynamic value) {
    final _$actionInfo =
        _$_DepartmentListViewModelBaseActionController.startAction(
            name: '_DepartmentListViewModelBase.changeSelectedEmployeeId');
    try {
      return super.changeSelectedEmployeeId(value);
    } finally {
      _$_DepartmentListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic filter(dynamic name) {
    final _$actionInfo = _$_DepartmentListViewModelBaseActionController
        .startAction(name: '_DepartmentListViewModelBase.filter');
    try {
      return super.filter(name);
    } finally {
      _$_DepartmentListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
departmentList: ${departmentList},
filteredDepartmanList: ${filteredDepartmanList},
pageState: ${pageState},
selectedEmployeeId: ${selectedEmployeeId}
    ''';
  }
}
