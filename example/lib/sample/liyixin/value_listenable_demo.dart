import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

/// ValueListenableBuilder实现局部刷新效果
class ValueListenableDemo extends StatefulWidget {
  const ValueListenableDemo({Key? key}) : super(key: key);

  @override
  State<ValueListenableDemo> createState() => _ValueListenableDemoState();
}

class _ValueListenableDemoState extends State<ValueListenableDemo> {
  final ValueNotifier<int> _counter = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: 'ValueListenable局部刷新',
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You have pushed the button this many times:'),
          ValueListenableBuilder(
              valueListenable: _counter,
              builder: (context, value, child) {
                return Text('${value}');
              }),
          OtherView()
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _incrementCounter() {
    _counter.value += 1;
  }
}

class OtherView extends StatefulWidget {
  const OtherView({Key? key}) : super(key: key);

  @override
  State<OtherView> createState() => _OtherViewState();
}

class _OtherViewState extends State<OtherView> {
  @override
  Widget build(BuildContext context) {
    print("_OtherViewState build....");
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        '我不会刷新的',
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
