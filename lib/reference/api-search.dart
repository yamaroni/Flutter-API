// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_api/models/data.dart';

Future<List<Data>> fetchData(id) async {
  final response = await http
      .get(Uri.parse('http://jsonplaceholder.typicode.com/posts/$id'));

  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((data) => Data.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}
