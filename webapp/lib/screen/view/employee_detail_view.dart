import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:webapp/core/constant/strings.dart';
import 'package:webapp/core/widgets/other/data_grid.dart';
import 'package:webapp/core/widgets/other/simple_container.dart';
import 'package:webapp/core/widgets/other/step_progress_indicator.dart';
import 'package:webapp/screen/service/asset_type_service.dart';
import '../../core/constant/enum/enums.dart';
import '../../core/network/network_manager.dart';
import '../../core/util/size_config.dart';
import '../../core/widgets/other/drop_down_input_text.dart';
import '../../core/widgets/other/input_text2.dart';
import '../model/time_off.dart';
import '../service/department_service.dart';
import '../service/employee_service.dart';
import '../service/shift_service.dart';
import '../service/site_service.dart';
import '../viewModel/employee_detail_view_model.dart';

class EmployeeDetailView extends StatelessWidget {
  final int? id;
  final BuildContext buildContext;
  EmployeeDetailView({super.key, required this.id, required this.buildContext});

  void _showCalendar(
      BuildContext context, TextEditingController textEditingController) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        locale: const Locale('tr'),
        initialDate: DateTime.now(),
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101),
        confirmText: "TAMAM");

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      textEditingController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    EmployeeDetailViewModel viewModel = EmployeeDetailViewModel(
      EmployeeService(networkManager: NetworkManager()),
      id,
      DepartmentService(networkManager: NetworkManager()),
      SiteService(networkManager: NetworkManager()),
      context,
      ShiftService(networkManager: NetworkManager()),
    );
    viewModel.init();
    return SingleChildScrollView(
        child: SizedBox(
            height: SizeConfig.blockSizeVertical * 80,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 90,
                    child:
                        buildPopUp(context, viewModel, _showCalendar, id)))));
  }

  Widget buildPopUp(
      BuildContext context,
      EmployeeDetailViewModel viewModel,
      void Function(BuildContext, TextEditingController) showCalendar,
      int? id) {
    return Center(
      child: Observer(builder: (_) {
        switch (viewModel.dataState) {
          case DataState.LOADING:
            return const Center(child: CircularProgressIndicator());
          case DataState.ERROR:
            return const Center(
                child: Text("Çalışan görüntülenirken bir hata oluştu"));
          default:
            return SimpleContainer(
              padding: 0,
              title: id == null
                  ? "Yeni Çalışan"
                  : "${viewModel.employeeDetail!.firstName ?? "Hata"} ${viewModel.employeeDetail!.firstName ?? ""}",
              child: id == null
                  ? buildGeneralInfo(viewModel, context)
                  : DefaultTabController(
                      length: 4,
                      child: Column(
                        children: [
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 90,
                            child: TabBar(
                              labelColor: Theme.of(context).colorScheme.primary,
                              labelStyle:
                                  Theme.of(context).textTheme.headlineMedium,
                              unselectedLabelColor: Colors.grey,
                              tabs: const [
                                Tab(text: "Genel Bilgiler"),
                                Tab(text: "İzin"),
                                Tab(text: "Zimmet"),
                                Tab(text: "Kariyer"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(children: [
                              buildGeneralInfo(viewModel, context),
                              buildTimeOffs(viewModel),
                              Observer(builder: (_) {
                                switch (viewModel.productsDataState) {
                                  case DataState.READY:
                                    return DataGrid(
                                      dataSourceList: viewModel
                                          .employeeDetail!.productList!,
                                      titles: const [
                                        "Id",
                                        "İsim",
                                        "Veriliş Tarihi"
                                      ],
                                      columnNames: const [
                                        "id",
                                        "name",
                                        "dateOfIssue"
                                      ],
                                    );

                                  case DataState.LOADING:
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  case DataState.ERROR:
                                    return const Center(
                                        child: Text(ERROR_MESSAGE));
                                  case DataState.EMPTY:
                                    return const Center(
                                        child: Text(
                                            "Üzerine zimmetli ürün bulunmamakta"));
                                }
                              }),
                              Container(),
                            ]),
                          ),
                        ],
                      ),
                    ),
            );
        }
      }),
    );
  }

  Row buildTimeOffs(EmployeeDetailViewModel viewModel) {
    return Row(
      children: [
        buildPreviousTimeOffs(viewModel),
        Expanded(
          child: Column(
            children: [
              buildPendingTimeOffs(viewModel),
              Expanded(
                  child: SimpleContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StepProgressIndicator(
                        padding: 0,
                        previousSteps: viewModel.currentTimeOff!.signHistories!,
                        futureSteps: viewModel.currentTimeOff!.managersToSign!),
                  ],
                ),
              ))
            ],
          ),
        )
      ],
    );
  }

  Expanded buildPreviousTimeOffs(EmployeeDetailViewModel viewModel) {
    return Expanded(
      child: SimpleContainer(
        title: "İzin Geçmişi",
        child: Observer(builder: (_) {
          switch (viewModel.previousTimeOffsDataState) {
            case DataState.READY:
              return buildDataGrid(
                  viewModel, viewModel.employeeDetail!.previousTimeOffs!);

            case DataState.LOADING:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case DataState.ERROR:
              return const Center(child: Text(ERROR_MESSAGE));
            case DataState.EMPTY:
              return const Center(child: Text("Geçmiş izin bulunmamakta"));
          }
        }),
      ),
    );
  }

  Expanded buildPendingTimeOffs(EmployeeDetailViewModel viewModel) {
    return Expanded(
      child: SimpleContainer(
        title: "Onay Bekleyen İzinler",
        child: Observer(builder: (_) {
          switch (viewModel.pendingTimeOffsDataState) {
            case DataState.READY:
              return buildDataGrid(
                  viewModel, viewModel.employeeDetail!.waitingTimeOffs!);

            case DataState.LOADING:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case DataState.ERROR:
              return const Center(child: Text(ERROR_MESSAGE));
            case DataState.EMPTY:
              return const Center(
                  child: Text("Onay bekleyen izin bulunmamakta"));
          }
        }),
      ),
    );
  }

  DataGrid buildDataGrid(
      EmployeeDetailViewModel viewModel, List<TimeOff> timeOffList) {
    return DataGrid(
      onRowTap: (startDate) {
        final DateFormat formatter = DateFormat('dd/MM/yyyy');
        final String formatted = formatter.format(startDate);
        viewModel.changeCurrentTimeOff(timeOffList
            .firstWhere((element) => element.startDate == formatted));
      },
      dataSourceList: timeOffList,
      columnNames: const ["startDate", "endDate", "status", "type"],
      titles: const [
        "Başlangıç Tarihi",
        "Bitiş Tarihi",
        "Onay Durumu",
        "İzin tipi"
      ],
    );
  }

  Row buildGeneralInfo(
      EmployeeDetailViewModel viewModel, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              buildGeneralInfos(viewModel, context),
              buildContaactInfo(viewModel),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              buildOtherInfos(viewModel, context),
              buildButtons(context, viewModel),
            ],
          ),
        ),
      ],
    );
  }

  Expanded buildOtherInfos(
      EmployeeDetailViewModel viewModel, BuildContext context) {
    return Expanded(
      child: SimpleContainer(
        padding: 4,
        title: "Diğer Bilgiler",
        child: Column(
          children: [
            buildRemainingTimeOffDaysInput(viewModel),
            buildDepartmentAndShiftInput(viewModel, context),
            buildClientTypeInput(
                viewModel, Theme.of(context).colorScheme.primary),
            buildAccessLocationsInput(context, viewModel),
          ],
        ),
      ),
    );
  }

  Expanded buildGeneralInfos(
      EmployeeDetailViewModel viewModel, BuildContext context) {
    return Expanded(
      flex: 6,
      child: SimpleContainer(
        padding: 4,
        title: "Genel Bilgiler",
        child: Column(
          children: [
            buildNameInput(viewModel),
            buildEmailAndIdInput(viewModel),
            buildBirthdateAndStartDateInput(viewModel),
            buildGenderInput(viewModel, context)
            //buildGenderInput(viewModel, context),
          ],
        ),
      ),
    );
  }

  Expanded buildContaactInfo(EmployeeDetailViewModel viewModel) {
    return Expanded(
      flex: 4,
      child: SimpleContainer(
        padding: 4,
        title: "İletişim Bilgileri",
        child: Column(
          children: [
            buildPhoneNumberAndAddressInput(viewModel),
            buildEmergencyInput(viewModel),
          ],
        ),
      ),
    );
  }

  Row buildAddressInput(EmployeeDetailViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          child: InputText2(
            textEditingController: viewModel.textEditingControllerList[11],
            icon: const Icon(Icons.location_city),
            hintText: "Adres",
          ),
        )
      ],
    );
  }

  Row buildEmergencyInput(EmployeeDetailViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          child: InputText2(
            textEditingController: viewModel.textEditingControllerList[9],
            icon: const Icon(Icons.person),
            hintText: "Acil Durum Yakın İsmi",
          ),
        ),
        Expanded(
          child: InputText2(
            textEditingController: viewModel.textEditingControllerList[10],
            icon: const Icon(Icons.phone),
            hintText: "Acil Durum Yakın Telefonu",
          ),
        ),
      ],
    );
  }

  Row buildPhoneNumberAndAddressInput(EmployeeDetailViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: InputText2(
            textEditingController: viewModel.textEditingControllerList[7],
            icon: const Icon(Icons.phone),
            hintText: "Cep Telefonu",
          ),
        ),
        Expanded(
          flex: 6,
          child: buildAddressInput(viewModel),
        )
      ],
    );
  }

  Row buildButtons(BuildContext context, EmployeeDetailViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            height: SizeConfig.blockSizeVertical * 4,
            width: SizeConfig.blockSizeHorizontal * 5,
            child: TextButton(
                onPressed: () async {
                  if (await viewModel.updateEmployee()) {
                    Navigator.pop(buildContext);
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor:
                        Theme.of(buildContext).colorScheme.primary),
                child: const Text("Kaydet",
                    style: TextStyle(color: Colors.white))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            height: SizeConfig.blockSizeVertical * 4,
            width: SizeConfig.blockSizeHorizontal * 5,
            child: TextButton(
                onPressed: () => Navigator.of(buildContext).pop(),
                child:
                    const Text("İptal", style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(
                    backgroundColor:
                        Theme.of(buildContext).colorScheme.primary)),
          ),
        ),
      ],
    );
  }

  Expanded buildGenderInput(
      EmployeeDetailViewModel viewModel, BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: DropDownInputText(
              title: "Cinsiyet",
              textEditingController: TextEditingController(
                  text: viewModel.employeeDetail!.gender == "MALE"
                      ? "Erkek"
                      : viewModel.employeeDetail!.gender == "FEMALE"
                          ? "Kadın"
                          : ""),
              items: const ["Erkek", "Kadın"],
              onTap: (index) {
                index == 0
                    ? viewModel.employeeDetail!.gender = "MALE"
                    : viewModel.employeeDetail!.gender = "FEMALE";
              },
            ),
          ),
        ],
      ),
    );
  }

  InputText2 buildRemainingTimeOffDaysInput(EmployeeDetailViewModel viewModel) {
    return InputText2(
        icon: const Icon(Icons.calendar_month),
        hintText: "Kalan İzin Günleri",
        textEditingController: viewModel.textEditingControllerList[6]);
  }

  Expanded buildAccessLocationsInput(
      BuildContext context, EmployeeDetailViewModel viewModel) {
    return Expanded(
      flex: 5,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: DropDownInputText(
                    title: "İzinli Olduğu Alanlar",
                    textEditingController: TextEditingController(),
                    items: viewModel.siteList!.map((e) => e.name).toList(),
                    onTap: (index) {
                      viewModel.siteId = viewModel.siteList![index].id;
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(2, 18, 2, 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextButton(
                                  onPressed: () =>
                                      viewModel.addSite(viewModel.siteId!),
                                  child: const Text("Ekle",
                                      style: TextStyle(color: Colors.white)),
                                  style: TextButton.styleFrom(
                                      backgroundColor: Theme.of(buildContext)
                                          .colorScheme
                                          .primary)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                      child: viewModel.siteListDataState == DataState.READY
                          ? DataTable(
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Id',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Ad',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      '',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                              ],
                              rows: viewModel.employeeDetail!.siteList != null
                                  ? viewModel.employeeDetail!
                                      .siteList! // Loops through dataColumnText, each iteration assigning the value to element
                                      .map(
                                        ((element) => DataRow(
                                              cells: <DataCell>[
                                                DataCell(Text(
                                                    element.id!.toString())),
                                                DataCell(Text(element
                                                    .name!)), //Extracting fro
                                                DataCell(Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () =>
                                                            viewModel
                                                                .removeSite(
                                                                    element
                                                                        .id!),
                                                        icon: const Icon(
                                                            Icons.close))
                                                  ],
                                                ))
                                              ],
                                            )),
                                      )
                                      .toList()
                                  : [],
                            )
                          : const Center(child: CircularProgressIndicator())),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding buildClientTypeInput(
      EmployeeDetailViewModel viewModel, Color primary) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text("Pozisyon", style: TextStyle(color: primary))),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CheckboxListTile(
                      title: const Text("Çalışan"),
                      value: viewModel.isEmployee,
                      onChanged: (value) => viewModel.changeIsEmployee(value!)),
                ),
              ),
              Expanded(
                flex: 5,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CheckboxListTile(
                      title: const Text("Yönetici"),
                      value: viewModel.isManager,
                      onChanged: (value) => viewModel.changeIsManager(value!)),
                ),
              ),
              Expanded(
                flex: 5,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CheckboxListTile(
                      title: const Text("Insan Kaynakları"),
                      value: viewModel.isHR,
                      onChanged: (value) => viewModel.changeIsHR(value!)),
                ),
              ),
              Expanded(
                flex: 5,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CheckboxListTile(
                      title: const Text("Admin"),
                      value: viewModel.isAdmin,
                      onChanged: (value) => viewModel.changeIsAdmin(value!)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row buildDepartmentAndShiftInput(
      EmployeeDetailViewModel viewModel, BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: DropDownInputText(
            title: "Departman",
            textEditingController: TextEditingController(
                text: viewModel.employeeDetail!.departmentId != null
                    ? viewModel.departmentList!
                            .firstWhere((element) =>
                                element.id ==
                                viewModel.employeeDetail!.departmentId)
                            .name ??
                        ""
                    : ""),
            items: viewModel.departmentList!.map((e) => e.name).toList(),
            onTap: (index) {
              viewModel.employeeDetail!.departmentId =
                  viewModel.departmentList![index].id;
            },
          ),
        ),
        Expanded(
          flex: 5,
          child: DropDownInputText(
            title: "Vardiya",
            textEditingController: TextEditingController(
                text: viewModel.employeeDetail!.shiftId != null
                    ? viewModel.shiftList!
                            .firstWhere((element) =>
                                element.id == viewModel.employeeDetail!.shiftId)
                            .name ??
                        ""
                    : ""),
            items: viewModel.shiftList!.map((e) => e.name).toList(),
            onTap: (index) {
              viewModel.employeeDetail!.shiftId =
                  viewModel.shiftList![index].id;
            },
          ),
        ),
      ],
    );
  }

  Row buildBirthdateAndStartDateInput(EmployeeDetailViewModel viewModel) {
    return Row(
      children: [
        Expanded(
            flex: 5,
            child: InputText2(
                onTap: () => _showCalendar(
                    buildContext, viewModel.textEditingControllerList[4]),
                icon: const Icon(Icons.date_range),
                hintText: "Doğum Tarihi",
                textEditingController: viewModel.textEditingControllerList[4])),
        Expanded(
            flex: 5,
            child: InputText2(
                onTap: () => _showCalendar(
                    buildContext, viewModel.textEditingControllerList[5]),
                icon: const Icon(Icons.date_range),
                hintText: "Başlangıç Tarihi",
                textEditingController: viewModel.textEditingControllerList[5])),
      ],
    );
  }

  Row buildEmailAndIdInput(EmployeeDetailViewModel viewModel) {
    return Row(
      children: [
        Expanded(
            flex: 5,
            child: InputText2(
                icon: const Icon(Icons.mail),
                hintText: "Email",
                textEditingController: viewModel.textEditingControllerList[2])),
        Expanded(
            flex: 5,
            child: InputText2(
                icon: const Icon(Icons.credit_card),
                hintText: "Kimlik Numarası",
                textEditingController: viewModel.textEditingControllerList[3])),
      ],
    );
  }

  Row buildNameInput(EmployeeDetailViewModel viewModel) {
    return Row(
      children: [
        Expanded(
            flex: 5,
            child: InputText2(
                icon: const Icon(Icons.person),
                hintText: "Ad",
                textEditingController: viewModel.textEditingControllerList[0])),
        Expanded(
            flex: 5,
            child: InputText2(
                icon: const Icon(Icons.person),
                hintText: "Soyad",
                textEditingController: viewModel.textEditingControllerList[1])),
      ],
    );
  }

  // Container buildProfileImage(ColorScheme colorScheme, ThemeData theme,
  //     EmployeeDetailViewModel employeeDetailViewModel) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       shape: BoxShape.rectangle,
  //     ),
  //     child: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           buildCircularImage(
  //               colorScheme,
  //               theme,
  //               getInitials((employeeDetailViewModel
  //                           .employeeDetail!.firstName ??
  //                       "Hata") +
  //                   " " +
  //                   (employeeDetailViewModel.employeeDetail!.lastName ?? ""))),
  //           buildName(theme, employeeDetailViewModel),
  //           buildEmail(theme, employeeDetailViewModel)
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Text buildEmail(
  //     ThemeData theme, EmployeeDetailViewModel employeeDetailViewModel) {
  //   return Text(
  //     employeeDetailViewModel.employeeDetail!.email ?? "Hata",
  //     style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
  //   );
  // }

  // Padding buildName(
  //     ThemeData theme, EmployeeDetailViewModel employeeDetailViewModel) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Text(
  //       employeeDetailViewModel.employeeDetail!.email ?? "Hata",
  //       style: theme.textTheme.headlineMedium,
  //     ),
  //   );
  // }

  // Container buildCircularImage(
  //     ColorScheme colorScheme, ThemeData theme, String nameInitials) {
  //   return Container(
  //     decoration: BoxDecoration(
  //         shape: BoxShape.circle,
  //         border: Border.all(color: colorScheme.primary, width: 3)),
  //     child: CircleAvatar(
  //       backgroundColor: Colors.grey.shade400,
  //       child: Text(nameInitials.toUpperCase(),
  //           style: theme.textTheme.headlineLarge!
  //               .copyWith(color: colorScheme.background)),
  //       radius: SizeConfig.blockSizeVertical * 5,
  //     ),
  //   );
  // }

  // String getInitials(String name) => name.isNotEmpty
  //     ? name
  //         .trim()
  //         .split(' ')
  //         .map((l) => l != "ve" ? l[0] : "")
  //         .take(2)
  //         .join()
  //         .toUpperCase()
  //     : '';
}
