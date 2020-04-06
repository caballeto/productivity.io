import 'package:flutter/material.dart';
import 'package:productivityio/models/project.dart';
import 'package:productivityio/widget/project_tile.dart';
import 'package:provider/provider.dart';

class ProjectList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final projects = Provider.of<List<Project>>(context) ?? [];
    return ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) => ProjectTile(project: projects[index])
    );
  }
}
