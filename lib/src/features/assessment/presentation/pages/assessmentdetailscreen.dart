import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class AssessmentDetailScreen extends StatelessWidget {
  const AssessmentDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Card(
                color: AppColor.transparentContainer.withOpacity(0.2),
                child: const Row(
                  children: [Text('Assessment Data')],
                ),
              )),
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Audience'),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          addAutomaticKeepAlives: true,
                          cacheExtent: BorderSide.strokeAlignOutside,
                          itemCount: 10,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              tileColor: AppColor.transparentContainer
                                  .withOpacity(0.2),
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
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
