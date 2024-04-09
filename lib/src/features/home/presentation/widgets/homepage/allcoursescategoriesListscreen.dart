import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/core/constants/text_style.dart';
import 'package:hermione/src/core/widgets/specialtextfield.dart';

class AllCourseCategoriesListScreen extends StatelessWidget {
  const AllCourseCategoriesListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Category'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: getScreenSize(context).width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SpecialTextfield(
                borderRadius: BorderRadius.circular(20),
                prefixwidget: const Icon(Icons.search),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: GridView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20,
                            mainAxisExtent: 200,
                            maxCrossAxisExtent: 200),
                    itemBuilder: (context, index) => Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: CircleAvatar(
                              child: Icon(
                                Icons.business,
                                color: AppColor.white,
                              ),
                              radius: 30,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(
                              20.0,
                            ),
                            child: Text(
                              'Science',
                              style: AppTextStyle.mediumTitlename
                                  .copyWith(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
