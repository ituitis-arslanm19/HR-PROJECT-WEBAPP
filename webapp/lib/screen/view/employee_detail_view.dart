import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:webapp/core/widgets/other/simple_container.dart';
import '../../core/constant/enum/enums.dart';
import '../../core/network/network_manager.dart';
import '../../core/util/size_config.dart';
import '../../core/widgets/other/input_text2.dart';
import '../model/department.dart';
import '../model/shift.dart';
import '../model/site.dart';
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
    return buildPopUp(context, viewModel, _showCalendar);
  }

  Widget buildPopUp(BuildContext context, EmployeeDetailViewModel viewModel,
      void Function(BuildContext, TextEditingController) showCalendar) {
    return Center(
      child: Observer(builder: (_) {
        switch (viewModel.dataState) {
          case DataState.LOADING:
            return const Center(child: CircularProgressIndicator());
          case DataState.ERROR:
            return const Center(
                child: Text("Çalışanlar görüntülenirken bir hata oluştu"));
          default:
            return SizedBox(
              width: SizeConfig.blockSizeHorizontal * 90,
              height: SizeConfig.blockSizeVertical * 80,
              child: SimpleContainer(
                title:
                    "${viewModel.employeeDetail!.firstName ?? "Hata"} ${viewModel.employeeDetail!.firstName ?? ""}",
                child: DefaultTabController(
                  length: 4,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: Theme.of(context).colorScheme.primary,
                        labelStyle: Theme.of(context).textTheme.headlineMedium,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          const Tab(text: "Genel Bilgiler"),
                          const Tab(text: "İzin"),
                          const Tab(text: "Zimmet"),
                          const Tab(text: "Kariyer"),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(children: [
                          buildGeneralInfo(viewModel, context),
                          Container(),
                          Container(),
                          Container(),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            );
        }
      }),
    );
  }

  Row buildGeneralInfo(
      EmployeeDetailViewModel viewModel, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              buildProfileImage(
                  Theme.of(context).colorScheme, Theme.of(context), viewModel)
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              buildNameInput(viewModel),
              buildEmailAndIdInput(viewModel),
              buildBirthdateAndStartDateInput(viewModel),
              buildDepartmentAndShiftInput(viewModel, context),
              buildClientTypeInput(viewModel),
              buildGenderInput(viewModel, context),
              buildButtons(context, viewModel),
            ],
          ),
        ),
      ],
    );
  }

  Row buildButtons(BuildContext context, EmployeeDetailViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width * 0.05,
            child: TextButton(
                onPressed: () async {
                  if (await viewModel.updateEmployee()) {
                    Navigator.pop(buildContext);
                  }
                },
                child:
                    const Text("Kaydet", style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(
                    backgroundColor:
                        Theme.of(buildContext).colorScheme.primary)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width * 0.05,
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
        children: [
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InputText2(
                    icon: const Icon(Icons.calendar_month),
                    hintText: "Kalan İzin Günleri",
                    textEditingController:
                        viewModel.textEditingControllerList[6]),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Cinsiyet")),
                      DropdownButtonFormField(
                          value: viewModel.employeeDetail!.gender,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey)),
                              iconColor: Theme.of(context).colorScheme.primary,
                              prefixIcon: const Icon(Icons.people)),
                          isExpanded: true,
                          items: const <DropdownMenuItem<String>>[
                            DropdownMenuItem(
                              value: "MALE",
                              child: Text("Erkek"),
                            ),
                            DropdownMenuItem(
                              value: "FEMALE",
                              child: Text("Kız"),
                            )
                          ],
                          onChanged: (value) {
                            viewModel.employeeDetail!.gender = value;
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("İzinli Olduğu Alan")),
                          Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: Container(
                                  height: 50,
                                  child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: Colors.grey)),
                                          iconColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          prefixIcon:
                                              const Icon(Icons.aspect_ratio)),
                                      isExpanded: true,
                                      items:
                                          viewModel.siteList!.map((Site items) {
                                        return DropdownMenuItem(
                                          value: items.id,
                                          child: Text(items.name!),
                                        );
                                      }).toList(),
                                      onChanged: (value) =>
                                          viewModel.changeSiteId(value!)),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, bottom: 2.0),
                                  height: 50,
                                  child: TextButton(
                                      onPressed: () =>
                                          viewModel.addSite(viewModel.siteId!),
                                      child: const Text("Ekle",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      style: TextButton.styleFrom(
                                          backgroundColor:
                                              Theme.of(buildContext)
                                                  .colorScheme
                                                  .primary)),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                            child: viewModel.siteListDataState ==
                                    DataState.READY
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
                                    rows: viewModel.employeeDetail!.siteList !=
                                            null
                                        ? viewModel.employeeDetail!
                                            .siteList! // Loops through dataColumnText, each iteration assigning the value to element
                                            .map(
                                              ((element) => DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(Text(element.id!
                                                          .toString())),
                                                      DataCell(Text(element
                                                          .name!)), //Extracting fro
                                                      DataCell(Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          IconButton(
                                                              onPressed: () =>
                                                                  viewModel.removeSite(
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
                                : const Center(
                                    child: CircularProgressIndicator())),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding buildClientTypeInput(EmployeeDetailViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(alignment: Alignment.centerLeft, child: Text("Pozisyon")),
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
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Align(
                    alignment: Alignment.centerLeft, child: Text("Departman")),
                DropdownButtonFormField(
                    value: viewModel.employeeDetail!.departmentId,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        iconColor: Theme.of(context).colorScheme.primary,
                        prefixIcon: const Icon(Icons.work)),
                    isExpanded: true,
                    items: viewModel.departmentList!.map((Department items) {
                      return DropdownMenuItem(
                        value: items.id,
                        child: Text(items.name!),
                      );
                    }).toList(),
                    onChanged: (value) {
                      viewModel.employeeDetail!.departmentId = value;
                    }),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Align(
                    alignment: Alignment.centerLeft, child: Text("Vardiya")),
                DropdownButtonFormField(
                    value: viewModel.employeeDetail!.shiftId,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        iconColor: Theme.of(context).colorScheme.primary,
                        prefixIcon: const Icon(Icons.access_alarm)),
                    isExpanded: true,
                    items: viewModel.shiftList!.map((Shift items) {
                      return DropdownMenuItem(
                        value: items.id,
                        child: Text(items.name!),
                      );
                    }).toList(),
                    onChanged: (value) {
                      viewModel.employeeDetail!.shiftId = value;
                    }),
              ],
            ),
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

  Container buildProfileImage(ColorScheme colorScheme, ThemeData theme,
      EmployeeDetailViewModel employeeDetailViewModel) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCircularImage(
                colorScheme,
                theme,
                getInitials((employeeDetailViewModel
                            .employeeDetail!.firstName ??
                        "Hata") +
                    " " +
                    (employeeDetailViewModel.employeeDetail!.lastName ?? ""))),
            buildName(theme, employeeDetailViewModel),
            buildEmail(theme, employeeDetailViewModel)
          ],
        ),
      ),
    );
  }

  Text buildEmail(
      ThemeData theme, EmployeeDetailViewModel employeeDetailViewModel) {
    return Text(
      employeeDetailViewModel.employeeDetail!.email ?? "Hata",
      style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
    );
  }

  Padding buildName(
      ThemeData theme, EmployeeDetailViewModel employeeDetailViewModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        employeeDetailViewModel.employeeDetail!.email ?? "Hata",
        style: theme.textTheme.headlineMedium,
      ),
    );
  }

  Container buildCircularImage(
      ColorScheme colorScheme, ThemeData theme, String nameInitials) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colorScheme.primary, width: 3)),
      child: CircleAvatar(
        backgroundColor: Colors.grey.shade400,
        child: Text(nameInitials.toUpperCase(),
            style: theme.textTheme.headlineLarge!
                .copyWith(color: colorScheme.background)),
        radius: SizeConfig.blockSizeVertical * 5,
      ),
    );
  }

  String getInitials(String name) => name.isNotEmpty
      ? name
          .trim()
          .split(' ')
          .map((l) => l != "ve" ? l[0] : "")
          .take(2)
          .join()
          .toUpperCase()
      : '';
}
