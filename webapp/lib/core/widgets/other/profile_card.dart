import 'package:flutter/material.dart';
import 'package:webapp/core/theme/app_theme.dart';
import 'package:webapp/core/util/size_config.dart';

class ProfileCard extends StatelessWidget {
  final String? tittle;
  final String? value;
  const ProfileCard({super.key, this.tittle, this.value});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Container(
            width: SizeConfig.blockSizeHorizontal * 88,
            child: Text("$tittle",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold)),
          ),
          Container(
              width: SizeConfig.blockSizeHorizontal * 88,
              height: SizeConfig.blockSizeVertical * 5,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: Text(
                  "$value",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ))
        ],
      ),
    );
  }
}
