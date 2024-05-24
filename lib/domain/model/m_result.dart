import 'dart:math';

class ResultModel {
  final int gridSizeV;
  final int gridSizeH;
  final List<Point<num>> walls;
  final Point start;
  final Point end;
  final String id;
  final List<Point<num>> path;

  ResultModel(
      {required this.gridSizeV,
      required this.gridSizeH,
      required this.walls,
      required this.start,
      required this.end,
      required this.id,
      required this.path});
}
