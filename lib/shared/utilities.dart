import 'package:productivityio/models/project.dart';
import 'package:productivityio/models/work_interval.dart';

String formatTitle({ String title, int limit = 25 }) {
  if (title == null) return '';
  if (title.isEmpty || title.length < limit) {
    return title;
  } else {
    return title.substring(0, limit) + '...';
  }
}

String formatDuration({ int time, bool seconds = true }) {
  Duration duration = Duration(milliseconds: time);
  String hoursMin = "${duration.inHours} hours, ${duration.inMinutes.remainder(60)} minutes";
  hoursMin += (seconds) ? ", ${duration.inSeconds.remainder(60)} seconds" : "";
  return hoursMin;
}

int getAllTime(List<Project> projects) {
  int sum = 0;
  projects.forEach((e) => e.intervals.forEach((x) => sum += x.end - x.start));
  return sum;
}

List<WorkInterval> getAllIntervals(List<Project> projects) {
  final List<WorkInterval> intervals = [];
  projects.forEach((e) => intervals.addAll(e.intervals));
  return intervals;
}