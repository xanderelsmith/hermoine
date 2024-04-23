import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/constants/constants.dart';

class Analytics extends StatefulWidget {
  const Analytics({
    super.key,
    required this.quiz,
  });
  final ParseObject quiz;

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    List quizlist = widget.quiz['viewers'] ?? [];
    List<QuizReportData> chartData = quizlist.map((e) {
      var date = DateTime.tryParse(e['date']['iso']);
      log(date!.minute.toString());
      return QuizReportData(
          color: Colors.primaries[9],
          date: date,
          score: e['score'],
          total: e['total'],
          username: e['user'].toString());
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
                  (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedIndex == index
                                  ? const Color(0xff065774)
                                  : Colors.grey),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                timeline[index],
                                style: AppTextStyle.mediumTitlename.copyWith(
                                  fontSize: 12,
                                ),
                              ),
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
                  labelFormat: '{value}%',
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
              tooltipBehavior: TooltipBehavior(
                  enable: true,
                  color: Colors.grey,
                  builder: (data, dynamic point, dynamic series, int pointIndex,
                      int seriesIndex) {
                    QuizReportData data2 = data;
                    return Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blueGrey,
                        ),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(data2.username.toString()),
                            Text(
                              ('${data2.score}/${data2.total}'.toString()),
                            )
                          ],
                        )));
                  }),
              onTooltipRender: (tooltipArgs) {
                return;
              },
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: ListView(
              children: List.generate(
                  chartData.length,
                  (index) => SizedBox(
                        width: getScreenSize(context).width,
                        height: 40,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(2.0),
                          leading: const CircleAvatar(
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(chartData[index].score.toString()),
                          title: Text(chartData[index].username),
                        ),
                      )),
            ),
          ))
        ],
      ),
    );
  }
}

const List timeline = ['Last Month', 'This Month', 'Today'];

/// The method returns line series to chart.
List<LineSeries<QuizReportData, num>> _getDefaultLineSeries(chartData) {
  return <LineSeries<QuizReportData, num>>[
    LineSeries<QuizReportData, num>(
        dataSource: chartData,
        pointColorMapper: (QuizReportData sales, _) => sales.color,
        dataLabelMapper: (datum, index) => 'hi',
        xValueMapper: (QuizReportData sales, _) => sales.date!.hour,
        yValueMapper: (QuizReportData sales, _) =>
            (sales.score / sales.total) * 100,
        name: 'Grade',
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
  final DateTime? date;
}
