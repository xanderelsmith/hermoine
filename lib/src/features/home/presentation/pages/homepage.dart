import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/core/global/userdetail.dart';
import '../widgets/styledappbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.userDetails});
  final UserDetails? userDetails;
  static String id = 'homepage';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [HomePageCourseCategory(), Courses()],
        ),
      ),
    );
  }
}

class Courses extends StatelessWidget {
  const Courses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Courses'),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 200,
                  maxCrossAxisExtent: 200),
              itemBuilder: (context, index) => Container(
                child: Column(
                  children: [
                    Expanded(child: SizedBox()),
                    Expanded(child: SizedBox()),
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                  color: index.isEven ? Colors.amber : Colors.red,
                ),
                height: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePageCourseCategory extends StatelessWidget {
  const HomePageCourseCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
