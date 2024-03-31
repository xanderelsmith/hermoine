import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hermione/src/features/assessment/data/sources/assessmentdatasources.dart';
import 'package:hermione/src/features/assessment/presentation/pages/assessmentdetailscreen.dart';
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

class CreateQuizScreen extends StatelessWidget {
  const CreateQuizScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: ElevatedButton(
          child: const Text('hi'),
          onPressed: () {},
        ),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: const Color(0xffC5CAE9).withOpacity(0.21),
          child: Column(
            children: [
              StyledTextField(
                innerHint: 'Quiz Name',
                fillColor: const Color(0xffC5CAE9).withOpacity(0.23),
                controller: TextEditingController(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropdownButton<int>(
                      value: 0,
                      items: List.generate(
                          25,
                          (index) => DropdownMenuItem(
                              value: index, child: Text(index.toString()))),
                      onChanged: (onChangedValue) {}),
                  DropdownButton<String>(
                      value: AssessmentDataSource.quizDifficulty[0],
                      items: List.generate(
                          AssessmentDataSource.quizDifficulty.length,
                          (index) => DropdownMenuItem(
                              value: AssessmentDataSource.quizDifficulty[index],
                              child: Text(AssessmentDataSource
                                  .quizDifficulty[index]
                                  .toString()))),
                      onChanged: (onChangedValue) {}),
                ],
              ),
              StyledTextField(
                innerHint: 'Enter any relevant data to obtain better results',
                textfieldname: 'Sample data',
                isMultiline: true,
                maxlines: 7,
                controller: TextEditingController(),
              ),
              CircleAvatar(
                  child: IconButton(
                      onPressed: () async {
                        File newfile;
                        await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: [
                              'pdf',
                            ]).then((value) {
                          if (value != null) {
                            newfile = File(value!.files.single.path!);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PdfQuizScreen(pdf: newfile)));
                          } else {}
                          return null;
                        }).onError((error, stackTrace) {
                          showSnackBar(context, message: error.toString());
                          return null;
                        });
                      },
                      icon: const Icon(Icons.dock_rounded))),
            ],
          ),
        ),
      ),
    );
  }
}
