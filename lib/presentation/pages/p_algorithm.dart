import 'dart:math';

import 'package:webspark_app/algoritm/pathfinder.dart';
import 'package:webspark_app/domain/model/m_path.dart';
import 'package:webspark_app/domain/model/m_result.dart';

class PathAlgorithm {
  List<double> walls = [];
  ResultModel calculatePth(Data data) {
    late ResultModel model;

    var gridSizeV = data.field!.length;
    var gridSizeH = data.field![0].length;

    var walls = makeWalls(data.field);

    model = (ResultModel(
        gridSizeV: gridSizeV,
        gridSizeH: gridSizeH,
        walls: walls,
        start: Point<num>(data.start!.x!, data.start!.y!),
        end: Point<num>(data.end!.x!, data.end!.y!),
        id: data.id!,
        path: []));

    List<Point<num>> resultPath = calculatePath(model);
    model.path.clear();
    model.path.addAll(resultPath);
    return model;
  }

  makeWalls(List<String>? field) {
    List<Point<num>> walls = [];
    for (var i = 0; i < field!.length; i++) {
      for (var j = 0; j < field[i].length; j++) {
        if (field[j][i] == "X") {
          walls.add(Point<num>(i, j));
        }
      }
    }
    return walls;
  }

  List<Point<num>> calculatePath(ResultModel model) {
    var path = PathFinder(model);
    List<Point<num>> a = path.findPath();
    return a;
  }
}
