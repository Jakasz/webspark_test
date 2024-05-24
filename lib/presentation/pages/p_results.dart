import 'package:flutter/material.dart';
import 'package:webspark_app/domain/model/m_result.dart';
import 'package:webspark_app/presentation/pages/p_presentation_grid.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.data});
  final List<ResultModel> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Results")),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (contex, index) {
            return InkWell(
              child: SizedBox(
                height: 60,
                child: Card(
                  child: Center(child: Text(data[index].path.toString())),
                ),
              ),
              onTapDown: (details) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PresentationGrid(
                            resultMode: data[index],
                          )),
                );
              },
            );
          }),
    );
  }
}
