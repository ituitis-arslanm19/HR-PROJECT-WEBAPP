import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final Icon? icon;
  final String? hintText;
  final TextEditingController textEditingController;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final bool? enabled;
  final bool? obscure;

  const InputText(
      {super.key,
      this.icon,
      this.enabled,
      this.hintText,
      required this.textEditingController,
      this.validator,
      this.onTap,
      this.obscure});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 4, right: 4),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          obscureText: obscure ?? false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          readOnly: enabled ?? false,
          controller: textEditingController,
          onTap: onTap,
          decoration: InputDecoration(
              focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.red,
                  )),
              errorStyle: const TextStyle(
                  color: Colors.red, fontSize: 0.01, height: 0.01),
              errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.red,
                  )),
              iconColor: Theme.of(context).colorScheme.primary,
              prefixIcon: icon,
              labelStyle:
                  theme.textTheme.bodySmall!.copyWith(color: theme.hintColor),
              border: InputBorder.none,
              labelText: hintText ?? "Hata"),
        ),
      ),
    );
  }
}
