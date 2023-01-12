import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class SetStateCounterDemo extends StatefulWidget {
  const SetStateCounterDemo({Key? key}) : super(key: key);

  @override
  State<SetStateCounterDemo> createState() => _SetStateCounterDemoState();
}

class _SetStateCounterDemoState extends State<SetStateCounterDemo> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    print('_SetStateCounterDemoState build...');
    return Scaffold(
      appBar: BrnAppBar(
        title: 'setState全局刷新',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You have pushed the button this many times:'),
            Text('${_counter}'),
            BottomView(),
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
      ),
    );
  }
}

class BottomView extends StatefulWidget {
  const BottomView({Key? key}) : super(key: key);

  @override
  State<BottomView> createState() => _BottomViewState();
}

class _BottomViewState extends State<BottomView> {
  @override
  Widget build(BuildContext context) {
    print('_BottomViewState build...');
    return Row(
      children: [
        Text('其实我没必要跟着Counter刷新'),
        TextButton(
            onPressed: () {
              setState(() {
                ///只是刷新了_BottomViewState，父view没有刷新。这就是ValueListenableBuilder的原理，在widget内部setState
              });
            },
            child: Text('只刷新我')),
      ],
    );
  }
}
