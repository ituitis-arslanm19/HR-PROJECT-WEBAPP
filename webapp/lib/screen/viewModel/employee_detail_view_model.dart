import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:webapp/screen/model/department_history.dart';
import 'package:webapp/screen/service/asset_service.dart';

import '../../core/constant/enum/enums.dart';
import '../model/asset.dart';
import '../model/department.dart';
import '../model/employee_detail.dart';
import '../model/shift.dart';
import '../model/site.dart';
import '../model/time_off.dart';
import '../service/department_service.dart';
import '../service/employee_service.dart';
import '../service/shift_service.dart';
import '../service/site_service.dart';
part 'employee_detail_view_model.g.dart';

class EmployeeDetailViewModel = _EmployeeDetailViewModelBase
    with _$EmployeeDetailViewModel;

abstract class _EmployeeDetailViewModelBase with Store {
  final EmployeeService employeeService;
  final DepartmentService departmentService;
  final SiteService siteService;
  final ShiftService shiftService;
  final AssetService assetService;
  final int? id;
  final bool? isHr;
  final BuildContext buildContext;
  List<TextEditingController> textEditingControllerList = [];

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  DataState previousTimeOffsDataState = DataState.LOADING;

  @observable
  DataState pendingTimeOffsDataState = DataState.LOADING;

  @observable
  TimeOff? currentTimeOff = TimeOff();

  @observable
  DataState productsDataState = DataState.LOADING;

  @observable
  DataState departmentHistoriesDataState = DataState.LOADING;

  @observable
  EmployeeDetail? employeeDetail;

  @observable
  List<Department>? departmentList;

  @observable
  List<DepartmentHistory>? departmentHistories;

  @observable
  List<Site>? siteList;

  @observable
  List<Shift>? shiftList;

  @observable
  DataState siteListDataState = DataState.READY;

  @observable
  List<Asset>? assetList;

  @observable
  bool? isManager;

  @observable
  bool? isEmployee;

  @observable
  bool? isAdmin;

  @observable
  bool? isHR;

  @observable
  int? siteId;

  _EmployeeDetailViewModelBase(
      this.employeeService,
      this.id,
      this.departmentService,
      this.siteService,
      this.buildContext,
      this.shiftService,
      this.assetService,
      {this.isHr = true});

  @action
  init() async {
    if (textEditingControllerList == [])
      textEditingControllerList =
          List.generate(12, (i) => TextEditingController());
    //Hr değil ise bu bilgilere ulaşamaz
    if (isHr!) {
      departmentList = await departmentService.getDepartments();
      siteList = await siteService.getSites();
      shiftList = await shiftService.getShifts();
    } else {
      departmentList = [];
      siteList = [];
      shiftList = [];
    }

    if (id == null) {
      employeeDetail = EmployeeDetail();
      employeeDetail!.siteList = <Site>[];
    } else {
      employeeDetail = await employeeService.getEmployeeDetail(id!);
      if (employeeDetail != null) {
        if (employeeDetail!.previousTimeOffs!.isNotEmpty) {
          previousTimeOffsDataState = DataState.READY;
          currentTimeOff = employeeDetail!.previousTimeOffs!.first;
        } else {
          previousTimeOffsDataState = DataState.EMPTY;
        }

        if (employeeDetail!.productList!.isNotEmpty) {
          productsDataState = DataState.READY;
          //print(employeeDetail!.productList![0].name);
        } else {
          productsDataState = DataState.EMPTY;
        }

        if (employeeDetail!.waitingTimeOffs!.isNotEmpty) {
          pendingTimeOffsDataState = DataState.READY;
          currentTimeOff = employeeDetail!.waitingTimeOffs!.first;
        } else {
          pendingTimeOffsDataState = DataState.EMPTY;
        }

        if (employeeDetail!.departmentHistories!.isNotEmpty) {
          departmentHistoriesDataState = DataState.READY;
        } else {
          departmentHistoriesDataState = DataState.EMPTY;
        }

        assetList = employeeDetail!.productList;
        departmentHistories = employeeDetail!.departmentHistories;
        isManager = employeeDetail!.roles != null
            ? employeeDetail!.roles!.contains("MANAGER")
            : false;
        isEmployee = employeeDetail!.roles != null
            ? employeeDetail!.roles!.contains("EMPLOYEE")
            : false;
        isHR = employeeDetail!.roles != null
            ? employeeDetail!.roles!.contains("HR")
            : false;
        isAdmin = employeeDetail!.roles != null
            ? employeeDetail!.roles!.contains("ADMIN")
            : false;
        textEditingControllerList.insert(
            0, TextEditingController(text: employeeDetail!.firstName));
        textEditingControllerList.insert(
            1, TextEditingController(text: employeeDetail!.lastName));
        textEditingControllerList.insert(
            2, TextEditingController(text: employeeDetail!.email));
        textEditingControllerList.insert(
            3,
            TextEditingController(
                text: employeeDetail!.identityNum != null
                    ? employeeDetail!.identityNum.toString()
                    : ""));
        textEditingControllerList.insert(
            4, TextEditingController(text: employeeDetail!.birthDate));
        textEditingControllerList.insert(
            5, TextEditingController(text: employeeDetail!.startDate));
        textEditingControllerList.insert(
            6,
            TextEditingController(
                text: employeeDetail!.remainingTimeOffDays != null
                    ? employeeDetail!.remainingTimeOffDays.toString()
                    : ""));
        textEditingControllerList.insert(
            7, TextEditingController(text: employeeDetail!.phoneNumber));
        textEditingControllerList.insert(
            8, TextEditingController(text: employeeDetail!.seniorityDate));
        textEditingControllerList.insert(9,
            TextEditingController(text: employeeDetail!.emergencyContactName));
        textEditingControllerList.insert(
            10,
            TextEditingController(
                text: employeeDetail!.emergencyContactNumber));
        textEditingControllerList.insert(
            11, TextEditingController(text: employeeDetail!.address));
        dataState = DataState.READY;
      } else {
        dataState = previousTimeOffsDataState = pendingTimeOffsDataState =
            departmentHistoriesDataState = DataState.ERROR;
      }
    }
  }

  @action
  changeIsManager(bool value) {
    isManager = value;
  }

  @action
  updateAssetList() async {
    var x = await employeeService.getEmployeeDetail(id!);
    assetList = x?.productList;
    if (assetList == null) {
      productsDataState = DataState.ERROR;
    } else {
      productsDataState =
          assetList!.isEmpty ? DataState.EMPTY : DataState.READY;
    }
  }

  @action
  deleteAsset(int id) async {
    await assetService.delete(id);

    updateAssetList();
  }

  @action
  deleteDepartmentHistory(int id1) async {
    var update = employeeDetail!;
    update.departmentHistories?.removeWhere((element) => element.id == id1);
    await employeeService.updateEmployee(update);
    EmployeeDetail? x = await employeeService.getEmployeeDetail(id!);
    departmentHistories = x?.departmentHistories;
  }

  @action
  updateDepartmentHistories(DepartmentHistory departmentHistory) async {
    EmployeeDetail update = employeeDetail!;
    update.departmentHistories?.add(departmentHistory);
    var x = await employeeService.updateEmployee(update);
    departmentHistories = x?.departmentHistories;
    if (departmentHistories == null) {
      departmentHistoriesDataState = DataState.ERROR;
    } else {
      departmentHistoriesDataState =
          departmentHistories!.isEmpty ? DataState.EMPTY : DataState.READY;
    }
  }

  @action
  changeIsEmployee(bool value) {
    isEmployee = value;
  }

  @action
  changeIsAdmin(bool value) {
    isAdmin = value;
  }

  @action
  changeIsHR(bool value) {
    isHR = value;
  }

  @action
  changeSiteId(int value) {
    siteId = value;
  }

  @action
  addSite(int value) async {
    siteListDataState = DataState.LOADING;
    Site? site = await siteService.getSiteById(value);
    if (site != null) {
      if (!employeeDetail!.siteList!.contains(site)) {
        employeeDetail!.siteList!.add(site);
      }
    }
    siteListDataState = DataState.READY;
  }

  @action
  removeSite(int value) async {
    siteListDataState = DataState.LOADING;
    employeeDetail!.siteList!.removeWhere((element) => element.id == value);
    siteListDataState = DataState.READY;
  }

  @action
  updateEmployee() async {
    employeeDetail!.firstName = textEditingControllerList[0].text;
    employeeDetail!.lastName = textEditingControllerList[1].text;
    employeeDetail!.email = textEditingControllerList[2].text;
    employeeDetail!.identityNum = textEditingControllerList[3].text != ""
        ? textEditingControllerList[3].text
        : null;
    employeeDetail!.birthDate = textEditingControllerList[4].text;
    employeeDetail!.startDate = textEditingControllerList[5].text;
    employeeDetail!.remainingTimeOffDays =
        textEditingControllerList[6].text != ""
            ? int.parse(textEditingControllerList[6].text)
            : null;
    employeeDetail!.phoneNumber = textEditingControllerList[7].text;
    employeeDetail!.seniorityDate = textEditingControllerList[8].text;
    employeeDetail!.emergencyContactName = textEditingControllerList[9].text;
    employeeDetail!.emergencyContactNumber = textEditingControllerList[10].text;
    employeeDetail!.address = textEditingControllerList[11].text;

    employeeDetail!.roles = [];
    if (isManager!) {
      employeeDetail!.roles!.add("MANAGER");
    }
    if (isEmployee!) {
      employeeDetail!.roles!.add("EMPLOYEE");
    }
    if (isHR!) {
      employeeDetail!.roles!.add("HR");
    }
    if (isAdmin!) {
      employeeDetail!.roles!.add("ADMIN");
    }
    EmployeeDetail? updatedEmployee;
    dataState = DataState.LOADING;
    if (employeeDetail!.id != null) {
      updatedEmployee = await employeeService.updateEmployee(employeeDetail!);
      if (updatedEmployee != null) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
            SnackBar(content: Text("Çalışan başarıyla güncellendi")));
        return true;
      } else {
        ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
            content: Text("Çalışan güncellenirken bir hata meydana geldi")));
      }
    } else {
      updatedEmployee = await employeeService.create(employeeDetail!);
      if (updatedEmployee != null) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
            SnackBar(content: Text("Çalışan başarıyla oluşturuldu")));
        return true;
      } else {
        ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
            content: Text("Çalışan oluştururken bir hata meydana geldi")));
      }
    }
    dataState = DataState.READY;
    return false;
  }

  @action
  changeCurrentTimeOff(TimeOff timeOff) {
    currentTimeOff = timeOff;
  }
}
