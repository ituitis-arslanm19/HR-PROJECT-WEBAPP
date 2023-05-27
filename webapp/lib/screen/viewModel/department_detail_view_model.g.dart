// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_detail_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DepartmentDetailViewModel on _DepartmentDetailViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_DepartmentDetailViewModelBase.dataState', context: context);

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

  late final _$departmentDetailAtom = Atom(
      name: '_DepartmentDetailViewModelBase.departmentDetail',
      context: context);

  @override
  DepartmentDetail? get departmentDetail {
    _$departmentDetailAtom.reportRead();
    return super.departmentDetail;
  }

  @override
  set departmentDetail(DepartmentDetail? value) {
    _$departmentDetailAtom.reportWrite(value, super.departmentDetail, () {
      super.departmentDetail = value;
    });
  }

  late final _$employeeListAtom = Atom(
      name: '_DepartmentDetailViewModelBase.employeeList', context: context);

  @override
  List<Employee>? get employeeList {
    _$employeeListAtom.reportRead();
    return super.employeeList;
  }

  @override
  set employeeList(List<Employee>? value) {
    _$employeeListAtom.reportWrite(value, super.employeeList, () {
      super.employeeList = value;
    });
  }

  late final _$managersToSignAtom = Atom(
      name: '_DepartmentDetailViewModelBase.managersToSign', context: context);

  @override
  List<EmployeeDetail>? get managersToSign {
    _$managersToSignAtom.reportRead();
    return super.managersToSign;
  }

  @override
  set managersToSign(List<EmployeeDetail>? value) {
    _$managersToSignAtom.reportWrite(value, super.managersToSign, () {
      super.managersToSign = value;
    });
  }

  late final _$employeeIdAtom =
      Atom(name: '_DepartmentDetailViewModelBase.employeeId', context: context);

  @override
  int? get employeeId {
    _$employeeIdAtom.reportRead();
    return super.employeeId;
  }

  @override
  set employeeId(int? value) {
    _$employeeIdAtom.reportWrite(value, super.employeeId, () {
      super.employeeId = value;
    });
  }

  late final _$employeeListDataStateAtom = Atom(
      name: '_DepartmentDetailViewModelBase.employeeListDataState',
      context: context);

  @override
  DataState get employeeListDataState {
    _$employeeListDataStateAtom.reportRead();
    return super.employeeListDataState;
  }

  @override
  set employeeListDataState(DataState value) {
    _$employeeListDataStateAtom.reportWrite(value, super.employeeListDataState,
        () {
      super.employeeListDataState = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_DepartmentDetailViewModelBase.init', context: context);

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$initManagerToSignAsyncAction = AsyncAction(
      '_DepartmentDetailViewModelBase.initManagerToSign',
      context: context);

  @override
  Future initManagerToSign() {
    return _$initManagerToSignAsyncAction.run(() => super.initManagerToSign());
  }

  late final _$addEmployeeAsyncAction = AsyncAction(
      '_DepartmentDetailViewModelBase.addEmployee',
      context: context);

  @override
  Future addEmployee(int value) {
    return _$addEmployeeAsyncAction.run(() => super.addEmployee(value));
  }

  late final _$removeEmployeeAsyncAction = AsyncAction(
      '_DepartmentDetailViewModelBase.removeEmployee',
      context: context);

  @override
  Future removeEmployee(int value) {
    return _$removeEmployeeAsyncAction.run(() => super.removeEmployee(value));
  }

  late final _$updateDepartmentAsyncAction = AsyncAction(
      '_DepartmentDetailViewModelBase.updateDepartment',
      context: context);

  @override
  Future updateDepartment() {
    return _$updateDepartmentAsyncAction.run(() => super.updateDepartment());
  }

  late final _$_DepartmentDetailViewModelBaseActionController =
      ActionController(
          name: '_DepartmentDetailViewModelBase', context: context);

  @override
  dynamic changeEmployeeId(int value) {
    final _$actionInfo = _$_DepartmentDetailViewModelBaseActionController
        .startAction(name: '_DepartmentDetailViewModelBase.changeEmployeeId');
    try {
      return super.changeEmployeeId(value);
    } finally {
      _$_DepartmentDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
departmentDetail: ${departmentDetail},
employeeList: ${employeeList},
managersToSign: ${managersToSign},
employeeId: ${employeeId},
employeeListDataState: ${employeeListDataState}
    ''';
  }
}
