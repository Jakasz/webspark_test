import 'dart:math';

import '../domain/model/m_result.dart';

class PathFinder {
  final ResultModel data;
  final List<Point<num>> finalPath = [];

  PathFinder(this.data);
  List<Point<num>> visitedNodes = [];
  List<List<Point<num>>> allFoundPaths = [];
  bool isFinalPathFound = false;
  List<Point<num>> findPath() {
    var stopFlag = 0;
    Point start = data.start;
    Point end = data.end;
    int sizeH = data.gridSizeH;
    int sizeV = data.gridSizeV;
    List<Point<num>> fields = _createFields(sizeH, sizeV);
    fields.removeWhere((element) => data.walls.contains(element));
    //set start point if it is first step
    List<Point<num>> localList = checkAndAddNeighbours(end, fields);
    //last items from 1st step of searching
    List<Point<num>> lastWave = [];
    for (var element in localList) {
      lastWave.add(element);
    }
    visitedNodes.add(end);
    localList.clear();
    List<Point<num>> path = [];
    path.add(end);
    while (stopFlag == 0) {
      // print("w = $lastWave");
      List<Point<num>> tempList = [];
      for (var element in lastWave) {
        tempList.clear();
        var nodes = checkAndAddNeighbours(element, fields);
        if (nodes.isNotEmpty) {
          tempList.addAll(nodes);
          if (nodes.contains(data.start)) {
            path.add(element);
            path.add(data.start);

            break;
          }
          path.add(element);
        } else {
          path.removeWhere((el) => element == el);
        }
      }
      lastWave.clear();
      lastWave.addAll(tempList);

      if (path.contains(start) && stopFlag == 0) {
        //stop and end calculations

        stopFlag = 1;
        break;
      }
    }

    return path;
  }

  List<Point<num>> _createFields(int sizeH, int sizeV) {
    List<Point<num>> fields = [];
    for (var i = 0; i <= sizeH - 1; i++) {
      for (var j = 0; j <= sizeV - 1; j++) {
        fields.add(Point(j, i));
      }
    }
    return fields;
  }

  List<Point<num>> checkAndAddNeighbours(
      Point<num> start, List<Point<num>> fields) {
    List<Point<num>> localVisitedPoints = [];
    var point = const Point<num>(0, 0);
    //check bottom
    point = Point(start.x + 1, start.y);
    if (fields.contains(point) && !visitedNodes.contains(point)) {
      visitedNodes.add(point);
      localVisitedPoints.add(point);
    }
    //check top
    point = Point(start.x - 1, start.y);
    if (fields.contains(point) && !visitedNodes.contains(point)) {
      visitedNodes.add(point);
      localVisitedPoints.add(point);
    }
    //check right
    point = Point(start.x, start.y + 1);
    if (fields.contains(point) && !visitedNodes.contains(point)) {
      visitedNodes.add(point);
      localVisitedPoints.add(point);
    }
    //check left
    point = Point(start.x, start.y - 1);
    if (fields.contains(point) && !visitedNodes.contains(point)) {
      visitedNodes.add(point);
      localVisitedPoints.add(point);
    }
    //check top right
    point = Point(start.x + 1, start.y - 1);
    if (fields.contains(point) && !visitedNodes.contains(point)) {
      visitedNodes.add(point);
      localVisitedPoints.add(point);
    }
    //check rhigt bottom
    point = Point(start.x + 1, start.y + 1);
    if (fields.contains(point) && !visitedNodes.contains(point)) {
      visitedNodes.add(point);
      localVisitedPoints.add(point);
    }
    //check left bottom
    point = Point(start.x - 1, start.y + 1);
    if (fields.contains(point) && !localVisitedPoints.contains(point)) {
      visitedNodes.add(point);
      localVisitedPoints.add(point);
    }
    //check left top
    point = Point(start.x - 1, start.y - 1);
    if (fields.contains(point) && !visitedNodes.contains(point)) {
      visitedNodes.add(point);
      localVisitedPoints.add(point);
    }

    return localVisitedPoints;
  }
}
