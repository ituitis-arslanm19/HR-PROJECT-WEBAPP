// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_list_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EmployeeListViewModel on _EmployeeListViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_EmployeeListViewModelBase.dataState', context: context);

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

  late final _$pageStateAtom =
      Atom(name: '_EmployeeListViewModelBase.pageState', context: context);

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
      name: '_EmployeeListViewModelBase.selectedEmployeeId', context: context);

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

  late final _$filteredEmployeeListAtom = Atom(
      name: '_EmployeeListViewModelBase.filteredEmployeeList',
      context: context);

  @override
  List<EmployeeListItem>? get filteredEmployeeList {
    _$filteredEmployeeListAtom.reportRead();
    return super.filteredEmployeeList;
  }

  @override
  set filteredEmployeeList(List<EmployeeListItem>? value) {
    _$filteredEmployeeListAtom.reportWrite(value, super.filteredEmployeeList,
        () {
      super.filteredEmployeeList = value;
    });
  }

  late final _$employeeListAtom =
      Atom(name: '_EmployeeListViewModelBase.employeeList', context: context);

  @override
  List<EmployeeListItem>? get employeeList {
    _$employeeListAtom.reportRead();
    return super.employeeList;
  }

  @override
  set employeeList(List<EmployeeListItem>? value) {
    _$employeeListAtom.reportWrite(value, super.employeeList, () {
      super.employeeList = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_EmployeeListViewModelBase.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$_EmployeeListViewModelBaseActionController =
      ActionController(name: '_EmployeeListViewModelBase', context: context);

  @override
  dynamic changePageState(dynamic value) {
    final _$actionInfo = _$_EmployeeListViewModelBaseActionController
        .startAction(name: '_EmployeeListViewModelBase.changePageState');
    try {
      return super.changePageState(value);
    } finally {
      _$_EmployeeListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeSelectedEmployeeId(dynamic value) {
    final _$actionInfo =
        _$_EmployeeListViewModelBaseActionController.startAction(
            name: '_EmployeeListViewModelBase.changeSelectedEmployeeId');
    try {
      return super.changeSelectedEmployeeId(value);
    } finally {
      _$_EmployeeListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic filter(dynamic name) {
    final _$actionInfo = _$_EmployeeListViewModelBaseActionController
        .startAction(name: '_EmployeeListViewModelBase.filter');
    try {
      return super.filter(name);
    } finally {
      _$_EmployeeListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
pageState: ${pageState},
selectedEmployeeId: ${selectedEmployeeId},
filteredEmployeeList: ${filteredEmployeeList},
employeeList: ${employeeList}
    ''';
  }
}
