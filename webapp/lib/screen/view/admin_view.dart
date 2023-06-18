import 'package:flutter/material.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/core/widgets/other/list_widget.dart';
import 'package:webapp/core/widgets/other/simple_container.dart';
import 'package:webapp/screen/model/access_location.dart';
import 'package:webapp/screen/model/asset.dart';
import 'package:webapp/screen/view/asset_view.dart';
import 'package:webapp/screen/view/employee_admin_view.dart';
import 'package:webapp/screen/view/reader_view.dart';
import 'package:webapp/screen/view/shift_view.dart';
import 'package:webapp/screen/view/site_view.dart';

import 'access_location_view.dart';
import 'department_admin_view.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Scaffold(
      body: DefaultTabController(
        length: 5,
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
                    Tab(text: "Departman"),
                    Tab(text: "Alan"),
                    Tab(text: "Giriş Noktası"),
                    Tab(text: "Okuyucular"),
                    Tab(text: "Vardiya"),
                  ]),
            ),
            Expanded(child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: theme.colorScheme.background,
                      border: Border.all(color: Colors.grey.shade300)),
                  child: const TabBarView(children: [
                    DepartmentView(),
                    SiteView(),
                    AccessLocationView(),
                    ReaderView(),
                    ShiftView()
                  ]),
                ),
              );
            }))
          ],
        ),
      ),
    );
  }
}
