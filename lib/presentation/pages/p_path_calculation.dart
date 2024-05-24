import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webspark_app/data/provider/instruction.dart';
import 'package:webspark_app/data/source/path_api.dart';
import 'package:webspark_app/domain/model/m_result.dart';
import 'package:webspark_app/presentation/pages/p_algorithm.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:webspark_app/presentation/pages/p_results.dart';

import '../../domain/model/m_path.dart';

class PathCalculations extends StatefulWidget {
  const PathCalculations({super.key, required this.url});

  final String url;

  @override
  State<PathCalculations> createState() => _PathCalculationsState();
}

class _PathCalculationsState extends State<PathCalculations> {
  List<ResultModel> models = [];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Instruction>(context, listen: false);

    getResults(models, provider);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calculations"),
        ),
        body: Consumer<Instruction>(builder: (context, pathData, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              pathData.percent != 1
                  ? const Center()
                  : Center(child: Text(pathData.responceMessage)),
              Center(
                child: CircularPercentIndicator(
                  radius: 80.0,
                  lineWidth: 10.0,
                  percent: pathData.percent,
                  center: Text("${pathData.percent}"),
                  progressColor: Colors.green,
                ),
              ),
              ElevatedButton(
                  onPressed: pathData.percent != 1
                      ? null
                      : () async {
                          List<String> responce = await postData(pathData);
                          pathData.setMessage(responce[0]);
                        },
                  child: const Text("send to server")),
              (pathData.percent == 1 &&
                      pathData.responceMessage == "Data sended succesfully")
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultPage(
                                    data: pathData.data,
                                  )),
                        );
                      },
                      child: const Text("open next step"))
                  : const Center(),
            ],
          );
        }));
  }

  Future<List<ResultModel>> getResultPaths(Instruction provider) async {
    List<ResultModel> resultPaths = [];

    final data = await getPathInstructions(provider);
    for (var i = 0; i <= data.data!.length - 1; i++) {
      var calculations = PathAlgorithm();
      var calculation = calculations.calculatePth(data.data![i]);

      resultPaths.add(calculation);
    }
    return resultPaths;
  }

  Future<PathData> getPathInstructions(Instruction provider) async {
    PathData data = await PathCall().fetchData(widget.url);
    provider.updatePercent(0.3);
    return data;
  }

  void getResults(List<ResultModel> models, Instruction provider) async {
    var finalData = await getResultPaths(provider);

    provider.updateData(finalData);
  }

  Future<List<String>> postData(Instruction provider) async {
    List<String> responceString = [];
    var bodyString = '';
    String tempBody = '[';
    for (var element in provider.data) {
      var stringPath = '';
      if (tempBody != '[') {
        tempBody = '$tempBody ,{"id": "${element.id}",';
      } else {
        tempBody = '$tempBody{"id": "${element.id}",';
      }
      tempBody = '$tempBody "result":{';
      tempBody = '$tempBody "steps":[';
      for (var i = 0; i < element.path.length - 1; i++) {
        tempBody =
            '$tempBody ${i == 0 ? "" : ","} {"x": "${element.path[i].x}", "y": "${element.path[i].y}"}';
        stringPath =
            '$stringPath(${element.path[i].x}, ${element.path[i].y})${i < element.path.length - 2 ? "->" : ""}';
      }
      tempBody = '$tempBody], "path": "$stringPath"}}';

      bodyString = '$bodyString $tempBody';
      tempBody = '';
    }
    bodyString = '$bodyString ]';

    Map<String, String> headers = {"Content-type": "application/json"};
    try {
      var response = await http.post(Uri.parse('https://flutter.webspark.dev/'),
          body: bodyString, headers: headers);
      if (response.statusCode == 200) {
        responceString.add("Data sended succesfully");
      }
    } catch (e) {
      responceString.add(e.toString());
    }
    return responceString;
  }
}
