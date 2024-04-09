import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hermione/src/features/home/presentation/widgets/homepage/allcoursescategoriesListscreen.dart';

class HomePageCourseCategory extends StatelessWidget {
  const HomePageCourseCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const AllCourseCategoriesListScreen()));
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Course Category'),
              Text('See more'),
            ],
          ),
        ),
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
