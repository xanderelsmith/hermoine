import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/core/global/userdetail.dart';
import 'package:hermione/src/core/utils/screensizeutils.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/sources/homepagedatasources.dart';
import '../widgets/bottomnavbar.dart';
import '../widgets/styledappbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.userDetails});
  final UserDetails? userDetails;
  static String id = 'homepage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Course Category'),
            SizedBox(
              height: 100,
              child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => const SizedBox(
                        height: 100,
                        width: 100,
                        child: Card(
                          child: Column(
                            children: [
                              Expanded(
                                child: CircleAvatar(
                                  child: Icon(Icons.business),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Science'),
                              )
                            ],
                          ),
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
