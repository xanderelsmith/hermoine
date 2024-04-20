import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/core/utils/screensizeutils.dart';
import 'package:hermione/src/features/assessment/data/sources/fetchquizes.dart';
import 'package:hermione/src/features/assessment/presentation/pages/assessmentdetailscreen.dart';
import 'package:hermione/src/features/assessment/presentation/pages/createquizscreen.dart';
import 'package:hermione/src/features/home/presentation/widgets/homepage/coursecategory.dart';
import 'package:hermione/src/features/home/presentation/widgets/homepage/courseslist.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import '../../../../../core/widgets/specialtextfield.dart';
import '../../../../assessment/data/sources/fetchcourses.dart';
import 'package:fl_chart/fl_chart.dart';

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
                                                                const Analytics()
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
  });

  @override
  Widget build(BuildContext context) {
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
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              title: ChartTitle(text: 'Inflation - Consumer price'),
              legend: Legend(
                  isVisible: false, overflowMode: LegendItemOverflowMode.wrap),
              primaryXAxis: NumericAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  interval: 2,
                  majorGridLines: const MajorGridLines(width: 0)),
              primaryYAxis: NumericAxis(
                  labelFormat: '{value}%',
                  interval: 10,
                  axisLine: const AxisLine(width: 0),
                  majorTickLines:
                      const MajorTickLines(color: Colors.transparent)),
              series: _getDefaultLineSeries(),
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

const List<QuizReportData> chartData = [
  QuizReportData(2005, 21, 28),
  QuizReportData(2006, 24, 44),
  QuizReportData(2007, 36, 48),
  QuizReportData(2008, 38, 50),
  QuizReportData(2009, 54, 66),
  QuizReportData(2010, 57, 78),
  QuizReportData(2011, 70, 84)
];

/// The method returns line series to chart.
List<LineSeries<QuizReportData, num>> _getDefaultLineSeries() {
  return <LineSeries<QuizReportData, num>>[
    LineSeries<QuizReportData, num>(
        dataSource: chartData,
        xValueMapper: (QuizReportData sales, _) => sales.x,
        yValueMapper: (QuizReportData sales, _) => sales.y,
        name: 'Germany',
        markerSettings: const MarkerSettings(isVisible: true)),
  ];
}

class QuizReportData {
  const QuizReportData(this.x, this.y, this.y2);
  final double x;
  final double y;
  final double y2;
}
