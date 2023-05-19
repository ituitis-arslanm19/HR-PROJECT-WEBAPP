import 'package:flutter/material.dart';
import 'package:webapp/core/util/size_config.dart';

class SearchField extends StatelessWidget {
  final TextEditingController textEditingController;
  void Function(String)? onChanged;

  SearchField({
    super.key,
    required this.textEditingController,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      width: SizeConfig.blockSizeHorizontal * 60,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: textEditingController,
        decoration: InputDecoration(
            border: InputBorder.none,
            iconColor: Theme.of(context).colorScheme.primary,
            prefixIcon: const Icon(Icons.search),
            labelText: "Lütfen aramak istediğiniz kelimeyi yazın"),
      ),
    );
  }
}
