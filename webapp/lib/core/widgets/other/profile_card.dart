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
                color: Theme.of(context).colorScheme.background,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
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
