import 'dart:math';

import 'package:flutter/material.dart';
import 'package:webspark_app/domain/model/m_result.dart';

class PresentationGrid extends StatelessWidget {
  const PresentationGrid({super.key, required this.resultMode});
  final ResultModel resultMode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(resultMode.id)),
      body: GridView.count(
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
          crossAxisCount: resultMode.gridSizeH,
          children: buildGrid(resultMode)),
    );
  }

  List<Widget> buildGrid(ResultModel resultMode) {
    List<Widget> list = [];
    var color = const Color.fromARGB(255, 255, 255, 255);
    for (var i = 0; i <= resultMode.gridSizeH - 1; i++) {
      for (var j = 0; j <= resultMode.gridSizeV - 1; j++) {
        if (resultMode.path.contains(Point(j, i))) {
          color = const Color.fromARGB(255, 76, 175, 80);
        }
        if (Point(j, i) == resultMode.start) {
          color = const Color.fromARGB(255, 100, 255, 218);
        }
        if (Point(j, i) == resultMode.end) {
          color = const Color.fromARGB(255, 0, 150, 136);
        }
        if (!resultMode.path.contains(Point(j, i))) {
          color = const Color.fromARGB(255, 0, 0, 0);
        }
        var widget = Container(
          color: color,
          child: Center(
              child: Text(
            Point(j, i).toString(),
            style: const TextStyle(color: Colors.white),
          )),
        );
        list.add(widget);
      }
    }
    return list;
  }
}
