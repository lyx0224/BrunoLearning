import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

/// RepeatBoundary包裹的widget是另外一个图层来刷新。缺点是使用更多的内存
///
///
class RepeatBoundaryDemo extends StatefulWidget {
  const RepeatBoundaryDemo({Key? key}) : super(key: key);

  @override
  State<RepeatBoundaryDemo> createState() => _RepeatBoundaryDemoState();
}

class _RepeatBoundaryDemoState extends State<RepeatBoundaryDemo> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(
          title: "RepeatBoundary局部刷新",
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You have pushed the button this many times:'),
              RepaintBoundary(
                child: Text('${_counter}'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _counter++;
            });
          },
          child: Icon(Icons.add),
        ));
  }
}
