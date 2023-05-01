import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final Icon? icon;
  final String? hintText;
  final TextEditingController textEditingController;
  void Function()? onTap;
  String? Function(String?)? validator;
  bool? enabled;
  bool? obscure;

  InputText(
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
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 2,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 245, 245, 245),
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
              border: InputBorder.none,
              labelText: hintText),
        ),
      ),
    );
  }
}
