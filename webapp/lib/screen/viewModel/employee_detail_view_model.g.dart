// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_detail_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EmployeeDetailViewModel on _EmployeeDetailViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_EmployeeDetailViewModelBase.dataState', context: context);

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

  late final _$employeeDetailAtom = Atom(
      name: '_EmployeeDetailViewModelBase.employeeDetail', context: context);

  @override
  EmployeeDetail? get employeeDetail {
    _$employeeDetailAtom.reportRead();
    return super.employeeDetail;
  }

  @override
  set employeeDetail(EmployeeDetail? value) {
    _$employeeDetailAtom.reportWrite(value, super.employeeDetail, () {
      super.employeeDetail = value;
    });
  }

  late final _$departmentListAtom = Atom(
      name: '_EmployeeDetailViewModelBase.departmentList', context: context);

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

  late final _$siteListAtom =
      Atom(name: '_EmployeeDetailViewModelBase.siteList', context: context);

  @override
  List<Site>? get siteList {
    _$siteListAtom.reportRead();
    return super.siteList;
  }

  @override
  set siteList(List<Site>? value) {
    _$siteListAtom.reportWrite(value, super.siteList, () {
      super.siteList = value;
    });
  }

  late final _$shiftListAtom =
      Atom(name: '_EmployeeDetailViewModelBase.shiftList', context: context);

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

  late final _$siteListDataStateAtom = Atom(
      name: '_EmployeeDetailViewModelBase.siteListDataState', context: context);

  @override
  DataState get siteListDataState {
    _$siteListDataStateAtom.reportRead();
    return super.siteListDataState;
  }

  @override
  set siteListDataState(DataState value) {
    _$siteListDataStateAtom.reportWrite(value, super.siteListDataState, () {
      super.siteListDataState = value;
    });
  }

  late final _$isManagerAtom =
      Atom(name: '_EmployeeDetailViewModelBase.isManager', context: context);

  @override
  bool? get isManager {
    _$isManagerAtom.reportRead();
    return super.isManager;
  }

  @override
  set isManager(bool? value) {
    _$isManagerAtom.reportWrite(value, super.isManager, () {
      super.isManager = value;
    });
  }

  late final _$isEmployeeAtom =
      Atom(name: '_EmployeeDetailViewModelBase.isEmployee', context: context);

  @override
  bool? get isEmployee {
    _$isEmployeeAtom.reportRead();
    return super.isEmployee;
  }

  @override
  set isEmployee(bool? value) {
    _$isEmployeeAtom.reportWrite(value, super.isEmployee, () {
      super.isEmployee = value;
    });
  }

  late final _$isAdminAtom =
      Atom(name: '_EmployeeDetailViewModelBase.isAdmin', context: context);

  @override
  bool? get isAdmin {
    _$isAdminAtom.reportRead();
    return super.isAdmin;
  }

  @override
  set isAdmin(bool? value) {
    _$isAdminAtom.reportWrite(value, super.isAdmin, () {
      super.isAdmin = value;
    });
  }

  late final _$isHRAtom =
      Atom(name: '_EmployeeDetailViewModelBase.isHR', context: context);

  @override
  bool? get isHR {
    _$isHRAtom.reportRead();
    return super.isHR;
  }

  @override
  set isHR(bool? value) {
    _$isHRAtom.reportWrite(value, super.isHR, () {
      super.isHR = value;
    });
  }

  late final _$siteIdAtom =
      Atom(name: '_EmployeeDetailViewModelBase.siteId', context: context);

  @override
  int? get siteId {
    _$siteIdAtom.reportRead();
    return super.siteId;
  }

  @override
  set siteId(int? value) {
    _$siteIdAtom.reportWrite(value, super.siteId, () {
      super.siteId = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_EmployeeDetailViewModelBase.init', context: context);

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$addSiteAsyncAction =
      AsyncAction('_EmployeeDetailViewModelBase.addSite', context: context);

  @override
  Future addSite(int value) {
    return _$addSiteAsyncAction.run(() => super.addSite(value));
  }

  late final _$removeSiteAsyncAction =
      AsyncAction('_EmployeeDetailViewModelBase.removeSite', context: context);

  @override
  Future removeSite(int value) {
    return _$removeSiteAsyncAction.run(() => super.removeSite(value));
  }

  late final _$updateEmployeeAsyncAction = AsyncAction(
      '_EmployeeDetailViewModelBase.updateEmployee',
      context: context);

  @override
  Future updateEmployee() {
    return _$updateEmployeeAsyncAction.run(() => super.updateEmployee());
  }

  late final _$_EmployeeDetailViewModelBaseActionController =
      ActionController(name: '_EmployeeDetailViewModelBase', context: context);

  @override
  dynamic changeIsManager(bool value) {
    final _$actionInfo = _$_EmployeeDetailViewModelBaseActionController
        .startAction(name: '_EmployeeDetailViewModelBase.changeIsManager');
    try {
      return super.changeIsManager(value);
    } finally {
      _$_EmployeeDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeIsEmployee(bool value) {
    final _$actionInfo = _$_EmployeeDetailViewModelBaseActionController
        .startAction(name: '_EmployeeDetailViewModelBase.changeIsEmployee');
    try {
      return super.changeIsEmployee(value);
    } finally {
      _$_EmployeeDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeIsAdmin(bool value) {
    final _$actionInfo = _$_EmployeeDetailViewModelBaseActionController
        .startAction(name: '_EmployeeDetailViewModelBase.changeIsAdmin');
    try {
      return super.changeIsAdmin(value);
    } finally {
      _$_EmployeeDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeIsHR(bool value) {
    final _$actionInfo = _$_EmployeeDetailViewModelBaseActionController
        .startAction(name: '_EmployeeDetailViewModelBase.changeIsHR');
    try {
      return super.changeIsHR(value);
    } finally {
      _$_EmployeeDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeSiteId(int value) {
    final _$actionInfo = _$_EmployeeDetailViewModelBaseActionController
        .startAction(name: '_EmployeeDetailViewModelBase.changeSiteId');
    try {
      return super.changeSiteId(value);
    } finally {
      _$_EmployeeDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
employeeDetail: ${employeeDetail},
departmentList: ${departmentList},
siteList: ${siteList},
shiftList: ${shiftList},
siteListDataState: ${siteListDataState},
isManager: ${isManager},
isEmployee: ${isEmployee},
isAdmin: ${isAdmin},
isHR: ${isHR},
siteId: ${siteId}
    ''';
  }
}
