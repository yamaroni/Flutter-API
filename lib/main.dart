// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'models/data.dart';
import 'reference/api-list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Data>> futureData;
  final _searchHandle = TextEditingController();

  void _printLatestValue() {
    print('Second text field: ${_searchHandle.text}');
  }

  @override
  void initState() {
    super.initState();

    futureData = fetchData();
    _searchHandle.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    _searchHandle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            search(),
            Expanded(child: list()),
          ],
        ),
      ),
    );
  }

  Widget search() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        controller: _searchHandle,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter a search term',
        ),
      ),
    );
  }

  Widget list() {
    return Center(
      child: FutureBuilder<List<Data>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Data>? data = snapshot.data;
            return ListView.builder(
                itemCount: data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                        title: Text(data[index].title),
                        subtitle: Text(data[index].body)),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
