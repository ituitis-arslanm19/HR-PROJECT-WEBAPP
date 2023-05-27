import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/constant/enum/enums.dart';
import '../model/department_detail.dart';
import '../model/employee.dart';
import '../model/employee_detail.dart';
import '../service/department_service.dart';
import '../service/employee_service.dart';
part 'department_detail_view_model.g.dart';

class DepartmentDetailViewModel = _DepartmentDetailViewModelBase
    with _$DepartmentDetailViewModel;

abstract class _DepartmentDetailViewModelBase with Store {
  final DepartmentService departmentService;
  final EmployeeService employeeService;
  final int? id;
  final BuildContext buildContext;
  List<TextEditingController> textEditingControllerList = [];

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  DepartmentDetail? departmentDetail;

  @observable
  List<Employee>? employeeList;

  @observable
  List<EmployeeDetail>? managersToSign = [];

  @observable
  int? employeeId;

  @observable
  DataState employeeListDataState = DataState.READY;

  _DepartmentDetailViewModelBase(
      this.departmentService, this.id, this.employeeService, this.buildContext);

  @action
  init() async {
    if (id == null) {
      departmentDetail = DepartmentDetail();
      departmentDetail!.managersToSignIds = <int>[];
    } else {
      departmentDetail = await departmentService.getDepartmentDetail(id!);
      await initManagerToSign();
    }
    textEditingControllerList
        .add(TextEditingController(text: departmentDetail!.name));
    employeeList = await employeeService.getManagers();
    if (departmentDetail != null) {
      dataState = DataState.READY;
    } else {
      dataState = DataState.ERROR;
    }
  }

  @action
  initManagerToSign() async {
    employeeListDataState = DataState.LOADING;
    departmentDetail!.managersToSignIds?.forEach((element) async {
      EmployeeDetail? managerToSign =
          await employeeService.getEmployeeDetail(element);
      managersToSign?.add(managerToSign!);
    });
    employeeListDataState = DataState.READY;
  }

  @action
  changeEmployeeId(int value) {
    employeeId = value;
  }

  @action
  addEmployee(int value) async {
    employeeListDataState = DataState.LOADING;
    EmployeeDetail? addedManager =
        await employeeService.getEmployeeDetail(value);
    if (!departmentDetail!.managersToSignIds!.contains(value)) {
      departmentDetail!.managersToSignIds!.add(value);
      managersToSign?.add(addedManager!);
    }
    employeeListDataState = DataState.READY;
  }

  @action
  removeEmployee(int value) async {
    employeeListDataState = DataState.LOADING;
    managersToSign!.removeWhere((element) => element.id == value);
    departmentDetail!.managersToSignIds!.remove(value);
    employeeListDataState = DataState.READY;
  }

  @action
  updateDepartment() async {
    departmentDetail!.name = textEditingControllerList[0].text;
    DepartmentDetail? updatedDepartment;
    dataState = DataState.LOADING;
    if (departmentDetail!.id != null) {
      updatedDepartment =
          await departmentService.updateDepartment(departmentDetail!);
      if (updatedDepartment != null) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
            SnackBar(content: Text("Departman başarıyla güncellendi")));
        return true;
      } else {
        ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
            content: Text("Departman güncellenirken bir hata meydana geldi")));
      }
    } else {
      updatedDepartment = await departmentService.create(departmentDetail!);
      if (updatedDepartment != null) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
            SnackBar(content: Text("Departman başarıyla oluşturuldu")));
        return true;
      } else {
        ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
            content: Text("Departman oluştururken bir hata meydana geldi")));
      }
    }
    dataState = DataState.READY;
    return false;
  }
}
