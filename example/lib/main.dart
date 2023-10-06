import 'dart:developer';

import 'package:example/simple_object.dart';
import 'package:flutter/material.dart';
import 'package:simple_expander/first_try/simple_expander_first.dart';
import 'package:simple_expander/first_try/tile.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Test page for SimpleExpander'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<SimpleObject> testValues = [
    SimpleObject(id: 1, name: "name", secondName: "secondName", moment: DateTime.now()),
    SimpleObject(id: 2, name: "name", secondName: "secondName", moment: DateTime.now()),
    SimpleObject(id: 3, name: "name", secondName: "secondName", moment: DateTime.now()),
    SimpleObject(id: 4, name: "name", secondName: "secondName", moment: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.grey,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedSimpleExpander(
                headerString: "Header title",
                tiles: testValues.map((e) => SimpleExpanderTile(
                  title: e.name,
                  subtitle: e.secondName,
                  onTap: () async {
                    log('henlo to number ${e.id}');
                  },
                  curve: 20,
                )).toList(),
              )
            ],
          ),
        ),
      )
    );
  }
}
