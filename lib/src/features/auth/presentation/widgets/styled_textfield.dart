import 'package:flutter/material.dart';

class StyledTextField extends StatelessWidget {
  final String? textfieldname;
  final String? innerHint;

  final TextInputType? textInputtype;
  final Widget? suffixwidget;
  final Function? onChanged;
  final TextCapitalization? textCapitalization;
  const StyledTextField({
    super.key,
    this.maxlines,
    this.controller,
    this.ishidden,
    this.onChanged,
    this.suffixwidget,
    this.isMultiline,
    this.textCapitalization,
    this.textInputtype,
    this.textfieldname,
    this.enableSuggestion,
    this.innerHint,
    this.fillColor,
  });
  final bool? ishidden;
  final bool? enableSuggestion;
  final TextEditingController? controller;
  final int? maxlines;
  final Color? fillColor;
  final bool? isMultiline;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      controller: controller,
      keyboardType: textInputtype,
      obscureText: ishidden ?? false,
      maxLines: isMultiline == false ? 1 : maxlines,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      autocorrect: false,
      enableSuggestions: enableSuggestion ?? false,
      decoration: InputDecoration(
        labelText: textfieldname,
        fillColor: fillColor ?? const Color(0xffC5CAE9).withOpacity(0.23),
        hintStyle: const TextStyle(fontWeight: FontWeight.w300),
        hintText: innerHint,
        filled: true,
        suffixIcon: suffixwidget,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
      ),
    );
  }
}
