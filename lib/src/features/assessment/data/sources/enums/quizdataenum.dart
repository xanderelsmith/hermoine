import 'package:flutter/material.dart';

enum QuizDataSource {
  fromText(icondata: Icons.text_fields, name: 'Text'),
  fromPdf(icondata: Icons.picture_as_pdf, name: 'Pdf');

  final String name;
  final IconData icondata;
  const QuizDataSource({required this.icondata, required this.name});
}
