import 'package:flutter/material.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/screen/view/asset_view.dart';
import 'package:webapp/screen/view/employee_admin_view.dart';
import 'package:webapp/screen/view/time_off_sign_view.dart';
import 'package:webapp/screen/view/time_off_type_view.dart';

class HrView extends StatelessWidget {
  const HrView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: TabBar(
                  labelColor: colorScheme.primary,
                  labelStyle: theme.textTheme.headlineMedium,
                  indicatorColor: colorScheme.primary,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: "Çalışan"),
                    Tab(text: "Zimmet"),
                    Tab(text: "İzin Tipi"),
                    Tab(text: "İzin Onayı"),
                  ]),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: theme.colorScheme.background,
                    border: Border.all(color: Colors.grey.shade300)),
                child: const TabBarView(children: [
                  EmployeeView(),
                  AssetView(),
                  TimeOffTypeView(),
                  TimeOffSignView()
                ]),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
