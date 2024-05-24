import 'package:flutter/material.dart';

import '../../domain/model/m_result.dart';

class Instruction extends ChangeNotifier {
  final List<ResultModel> _data = [];

  double percent = 0.2;
  String responceMessage =
      'All calculation has finished. You can send results to server';
  List<ResultModel> get data => _data;

  updateData(List<ResultModel> localData) {
    _data.clear();
    _data.addAll(localData);
    percent = 1;

    notifyListeners();
  }

  void updatePercent(double i) {
    percent = i;
    notifyListeners();
  }

  void setMessage(String responce) {
    responceMessage = responce;
    notifyListeners();
  }
}
