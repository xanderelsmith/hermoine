import 'package:flutter/material.dart';

class StyledTextField extends StatelessWidget {
  const StyledTextField({
    super.key,
    required this.hint,
    required this.textEditingController,
  });
  final String hint;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 28.0,
        vertical: 10,
      ),
      child: SizedBox(
        height: 50,
        child: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
              fillColor: const Color(0xffC5CAE9),
              hintText: hint,
              border: const OutlineInputBorder()),
        ),
      ),
    );
  }
}
