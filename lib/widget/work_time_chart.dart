import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:productivityio/models/work_interval.dart';

class WorkTimeChart extends StatelessWidget {
  final List<WorkInterval> intervals;
  final bool animate;

  WorkTimeChart(this.intervals, {this.animate = false});

  @override
  Widget build(BuildContext context) {
    final seriesList = _createChart(intervals);
    return charts.BarChart(
      seriesList,
      animate: animate,
      domainAxis: charts.OrdinalAxisSpec(),
    );
  }
}

List<charts.Series<WorkDay, String>> _createChart(List<WorkInterval> intervals) {
  final data = _fromWorkIntervals(intervals);
  return [
    charts.Series(
      id: 'Work timeline',
      domainFn: (WorkDay day, _) => day.date,
      measureFn: (WorkDay day, _) => day.minutes,
      data: data
    )
  ];
}

List<WorkDay> _fromWorkIntervals(List<WorkInterval> intervals) {
  var formatter = DateFormat('dd/mm/yy');
  Map<String, int> days = Map();
  _getWeekDates().forEach((e) => days[e] = 0);
  for (final interval in intervals) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(interval.start);
    final repr = formatter.format(DateTime(date.year, date.month, date.day));
    if (days.containsKey(repr)) {
      days[repr] += interval.end - interval.start;
    }
  }

  return days.entries.map((e) => WorkDay(e.key.substring(0, 2), (e.value / 60000).round())).toList();
}

List<String> _getWeekDates() {
  DateTime now = DateTime.now(), today = DateTime(now.year, now.month, now.day);
  var formatter = DateFormat('dd/mm/yy');
  return [
    today.subtract(Duration(days: 6)),
    today.subtract(Duration(days: 5)),
    today.subtract(Duration(days: 4)),
    today.subtract(Duration(days: 3)),
    today.subtract(Duration(days: 2)),
    today.subtract(Duration(days: 1)),
    today
  ].map((e) => formatter.format(e)).toList();
}


class WorkDay {
  final String date;
  final int minutes;

  WorkDay(this.date, this.minutes);
}
