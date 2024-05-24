import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:webspark_app/presentation/pages/p_path_calculation.dart';

class UrlPage extends StatefulWidget {
  const UrlPage({super.key});

  @override
  State<UrlPage> createState() => _UrlPageState();
}

class _UrlPageState extends State<UrlPage> {
  late TextEditingController textEditingController;
  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textEditingController.text = "https://flutter.webspark.dev/flutter/api";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen1"),
      ),
      body: Column(
        children: [
          const Text("Set valid API base URL as order to continue"),
          Row(
            children: [
              const Icon(Icons.favorite),
              Expanded(
                child: TextFormField(
                  controller: textEditingController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter url',
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                if (isURL(textEditingController.text)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PathCalculations(url: textEditingController.text)),
                  );
                }
              },
              child: const Text("Go next")),
        ],
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
