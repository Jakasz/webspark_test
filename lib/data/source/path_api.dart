import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/model/m_path.dart';

class PathCall {
  Future<PathData> fetchData(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return PathData.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load path data');
    }
  }
}
