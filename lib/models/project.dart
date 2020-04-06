import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productivityio/models/work_interval.dart';

class Project {
  final String id;
  String name;
  final DateTime createdAt;
  int workedTime;
  final List<WorkInterval> intervals;

  Project({
    this.id,
    this.name,
    DateTime createdAt,
    int workedTime,
    List<WorkInterval> intervals
  }) : this.createdAt = createdAt ?? DateTime.now(),
        this.workedTime = workedTime ?? 0,
        this.intervals = intervals ?? List();

  static List<Project> fromQuery(QuerySnapshot query) => query != null ? toProjects(query) : [];

  Map<String, dynamic> toJson() {
    final List<Map<String, dynamic>> intervals = [];
    this.intervals.forEach((e) => intervals.add({'start': e.start, 'end': e.end}));

    return {
      'name': name,
      'createdAt': (createdAt ?? DateTime.now()).millisecondsSinceEpoch,
      'workedTime': workedTime,
      'intervals': intervals
    };
  }
}

List<Project> toProjects(QuerySnapshot query) => query.documents
    .map((e) => toProject(e))
    .where((e) => e != null)
    .toList();

Project toProject(DocumentSnapshot doc) {
  final intervals = <WorkInterval>[];
  (doc.data['intervals'] ?? []).forEach((e) => intervals.add(WorkInterval.fromJson(e)));
  return doc.exists
    ? Project(
      id: doc.documentID,
      name: doc.data['name'],
      createdAt: DateTime.fromMicrosecondsSinceEpoch(doc.data['createdAt'] ?? 0),
      workedTime: doc.data['workedTime'],
      intervals: intervals
    ) : null;
}