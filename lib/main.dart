// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });

  List<DataModel> dataSet = [
    DataModel(individualNumber: 40, name: 'First', color: 0xff73C6B6),
    DataModel(individualNumber: 150, name: 'Second', color: 0xF0B27A),
    DataModel(individualNumber: 180, name: 'Third', color: 0x85929E),
    DataModel(individualNumber: 180, name: 'Fourth', color: 0x9A7D0A),
    DataModel(individualNumber: 450, name: 'Fourth', color: 0xE74C3C),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Horizontal Bar',
      home: MyHomePage(
        title: 'Dynamic Horizontal Bar',
        dataSet: dataSet,
        height: 40,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  double height;
  final String title;
  List<DataModel> dataSet;

  MyHomePage(
      {super.key,
      required this.title,
      this.height = 25,
      required this.dataSet});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedBar = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: widget.height,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: widget.dataSet
                      .map((e) => Tooltip(
                            message:
                                '${e.name}\n${(e.individualNumber / widget.dataSet.fold(0, (previousValue, element) => previousValue + element.individualNumber) * 100).toStringAsFixed(2)}%',
                            triggerMode: TooltipTriggerMode.tap,
                            onTriggered: () {
                              setState(() {
                                selectedBar = widget.dataSet.indexOf(e);
                              });
                            },
                            child: AnimatedContainer(
                              alignment: Alignment.center,
                              duration: const Duration(seconds: 2),
                              height: selectedBar == widget.dataSet.indexOf(e)
                                  ? (widget.height)
                                  : widget.height - 10,
                              width: ((e.individualNumber *
                                  (MediaQuery.of(context).size.width) /
                                  widget.dataSet.fold(
                                      0,
                                      (previousValue, element) =>
                                          previousValue +
                                          element.individualNumber))),
                              decoration: BoxDecoration(
                                color: Color(e.color).withOpacity(1.0),
                              ),
                              child: FittedBox(
                                child: Text(
                                    '${(e.individualNumber / widget.dataSet.fold(0, (previousValue, element) => previousValue + element.individualNumber) * 100).toStringAsFixed(2)}%'),
                              ),
                            ),
                          ))
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }
}

class DataModel {
  double individualNumber;
  String name;
  int color;
  DataModel(
      {required this.individualNumber,
      required this.color,
      required this.name});
}
