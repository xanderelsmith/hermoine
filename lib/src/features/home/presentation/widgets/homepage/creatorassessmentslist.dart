import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/core/utils/screensizeutils.dart';
import 'package:hermione/src/features/assessment/data/sources/fetchquizes.dart';
import 'package:hermione/src/features/assessment/presentation/pages/createquizscreen.dart';
import 'package:hermione/src/features/home/presentation/widgets/homepage/coursecategory.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../core/widgets/specialtextfield.dart';
import '../../../../assessment/data/sources/fetchcourses.dart';

class CreatorAssessmentScreen extends StatelessWidget {
  const CreatorAssessmentScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateQuizScreen()));
            },
            child: const Icon(
              Icons.create_outlined,
              color: Colors.white,
            )),
        appBar: AppBar(
          title: const Text('Scheduled Assessments'),
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
                      SizedBox(
                        height: 50,
                        child: FutureBuilder<List<ParseObject>?>(
                            future: CoursesApiFetch.getAllCourses(),
                            builder: (context, snapshot) {
                              return !snapshot.hasData
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Builder(builder: (context) {
                                      return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: ((context, index) {
                                            ParseObject course =
                                                snapshot.data![index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Chip(
                                                  label: Text(course['name'])),
                                            );
                                          }));
                                    });
                            }),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FutureBuilder<List<ParseObject>?>(
                              future: QuizApiFetch.getAllquizes(),
                              builder: (context, snapshot) {
                                return !snapshot.hasData
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          ParseFile src =
                                              snapshot.data![index]['image'];
                                          return QuizListTile(
                                              imageurl: src.url ?? '',
                                              screensize:
                                                  getScreenSize(context),
                                              onTap: () {
                                                log('ji');
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                                Analytics(
                                                                  quiz: snapshot
                                                                          .data![
                                                                      index],
                                                                )
                                                            // const AssessmentDetailScreen()

                                                            )));
                                              },
                                              quizname: snapshot.data![index]
                                                  ['topic'],
                                              datecreated: 'datecreated',
                                              username: snapshot.data![index]
                                                  ['author'],
                                              isViewed: true,
                                              quizEmojis: const [],
                                              presentUser: 'presentUser');
                                        });
                              }),
                        ),
                      )
                    ]))));
  }
}

class Analytics extends StatelessWidget {
  const Analytics({
    super.key,
    required this.quiz,
  });
  final ParseObject quiz;
  @override
  Widget build(BuildContext context) {
    List quizlist = quiz['viewers'] ?? [];
    List<QuizReportData> chartData = quizlist.map((e) {
      log(e['date'].toString());
      return QuizReportData(
          color: Colors.primaries.first,
          date: e['date'],
          score: e['score'],
          total: e['total'],
          username: e['user'] ?? '');
    }).toList();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff065774),
        title: const Text('Analytics'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  3,
                  (index) => Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xff065774)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              timeline[index],
                              style: AppTextStyle.mediumTitlename
                                  .copyWith(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      )),
            ),
          ),
          Expanded(
            flex: 2,
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              title: ChartTitle(text: 'Score - Time'),
              primaryXAxis: NumericAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  interval: 2,
                  maximum: 24,
                  majorGridLines: const MajorGridLines(width: 0)),
              primaryYAxis: NumericAxis(
                  labelFormat: '{value}%',
                  interval: 2,
                  maximum: 100,
                  axisLine: const AxisLine(width: 0),
                  majorTickLines:
                      const MajorTickLines(color: Colors.transparent)),
              series: _getDefaultLineSeries(chartData),
              tooltipBehavior: TooltipBehavior(enable: true),
            ),
          ),
          const Expanded(child: SizedBox())
        ],
      ),
    );
  }
}

List timeline = ['Last 7 hours', 'Last 10 hours', 'Today'];

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

/// The method returns line series to chart.
List<LineSeries<QuizReportData, num>> _getDefaultLineSeries(chartData) {
  return <LineSeries<QuizReportData, num>>[
    LineSeries<QuizReportData, num>(
        dataSource: chartData,
        xValueMapper: (QuizReportData sales, _) => sales.score,
        yValueMapper: (QuizReportData sales, _) =>
            (sales.score / sales.total) * 100,
        name: 'Score',
        markerSettings: const MarkerSettings(
          isVisible: true,
        )),
  ];
}

class QuizReportData {
  const QuizReportData(
      {required this.username,
      required this.color,
      required this.date,
      required this.score,
      required this.total});
  final String username;
  final int score;
  final Color color;
  final int total;
  final Map date;
}
