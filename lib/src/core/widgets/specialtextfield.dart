import 'package:flutter/material.dart';

class SpecialTextfield extends StatelessWidget {
  final String? textfieldname;
  final String? innerHint;

  final TextInputType? textInputtype;
  final Widget? suffixwidget;
  final Widget? prefixwidget;
  final Function? onChanged;
  final TextCapitalization? textCapitalization;
  const SpecialTextfield({
    Key? key,
    this.maxlines,
    this.controller,
    this.ishidden,
    this.onChanged,
    this.suffixwidget,
    this.prefixwidget,
    this.isMultiline,
    this.textCapitalization,
    this.textInputtype,
    this.textfieldname,
    this.enableSuggestion,
    this.innerHint,
    this.borderRadius,
  }) : super(key: key);
  final bool? ishidden;
  final BorderRadius? borderRadius;
  final bool? enableSuggestion;
  final TextEditingController? controller;
  final int? maxlines;
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
        contentPadding: EdgeInsets.zero,
        fillColor: Theme.of(context).canvasColor.withOpacity(0.8),
        hintStyle: const TextStyle(fontWeight: FontWeight.w300),
        hintText: innerHint,
        filled: true,
        suffixIcon: suffixwidget,
        prefixIcon: prefixwidget,
        border: OutlineInputBorder(
            borderRadius:
                borderRadius ?? const BorderRadius.all(Radius.circular(4.0)),
            borderSide: const BorderSide(color: Colors.black)),
      ),
    );
  }
}
