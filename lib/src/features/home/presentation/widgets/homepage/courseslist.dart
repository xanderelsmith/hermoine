import 'package:flutter/material.dart';

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Courses '),
                Text('See more'),
              ],
            ),
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
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                  color: index.isEven ? Colors.amber : Colors.red,
                ),
                height: 200,
                child: const Column(
                  children: [
                    Expanded(child: SizedBox()),
                    Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
