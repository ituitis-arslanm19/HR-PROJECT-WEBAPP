import 'package:flutter/material.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/screen/view/new_time_off_view.dart';
import 'package:webapp/screen/view/product_view.dart';
import 'package:webapp/screen/view/profile_view.dart';
import 'package:webapp/screen/view/time_off_approval_view.dart';
import 'package:webapp/screen/view/time_off_view.dart';

import '../../core/widgets/other/shadow_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: SizedBox(
                height: SizeConfig.blockSizeVertical * 80,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ShadowContainer(child: ProfileView()),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //buildBottomLeft(theme, colorScheme),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 40,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ShadowContainer(child: buildTopRight()),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 40,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ShadowContainer(
                          child: buildBottomRight(theme, colorScheme)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ProductView buildBottomRight(ThemeData theme, ColorScheme colorScheme) =>
      ProductView();

  NewTimeOffView buildTopRight() => NewTimeOffView();
  TimeOffView buildTopLeft(ThemeData theme, ColorScheme colorScheme) =>
      TimeOffView();
}



//  Expanded(
//                 flex: 4,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                       decoration: BoxDecoration(
//                         color: colorScheme.background,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             blurRadius: 2,
//                             offset: const Offset(
//                                 0, 5), // changes position of shadow
//                           ),
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             blurRadius: 2,
//                             offset: const Offset(
//                                 0, 0), // changes position of shadow
//                           ),
//                         ],
//                       ),
//                       height: SizeConfig.blockSizeVertical * 60,
//                       child: Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: buildTopLeft(theme, colorScheme),
//                       )),
//                 ),
//               ),