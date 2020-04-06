// work interval to record job intervals, in milliseconds
class WorkInterval {
  int start;
  int end;

  WorkInterval({ this.start, this.end });

  Map<String, dynamic> toJson() => {
    'start': start,
    'end': end
  };

  static WorkInterval fromJson(e) => WorkInterval(start: e['start'], end: e['end']);
}