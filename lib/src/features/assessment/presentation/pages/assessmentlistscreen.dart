import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hermione/src/features/assessment/data/sources/assessmentdatasources.dart';
import 'package:hermione/src/features/assessment/presentation/pages/assessmentdetailscreen.dart';
import 'package:hermione/src/features/assessment/presentation/pages/createquizscreen.dart';
import 'package:hermione/src/features/assessment/presentation/pages/pdfquizifyscreen.dart';
import 'package:hermione/src/features/auth/domain/entities/loginvalidator.dart';
import 'package:hermione/src/features/auth/presentation/widgets/styled_textfield.dart';

import '../../../../core/constants/colors.dart';

class AllAssessments extends StatelessWidget {
  const AllAssessments({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Assessments'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => const CreateQuizScreen()),
              ),
            );
          },
          child: const Icon(Icons.create_outlined),
        ),
        body: SafeArea(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            // addAutomaticKeepAlives: true,
            cacheExtent: BorderSide.strokeAlignOutside,
            itemCount: 10,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                tileColor: AppColor.transparentContainer.withOpacity(0.2),
                leading: const CircleAvatar(),
                subtitle: const Text('Mrs johny'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AssessmentDetailScreen()));
                },
                title: const Text('Physics, Chemistry'),
                trailing: const Text('40 mins ago'),
              ),
            ),
          ),
        ));
  }
}
