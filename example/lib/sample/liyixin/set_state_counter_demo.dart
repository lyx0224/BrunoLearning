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
    return Scaffold(
      appBar: BrnAppBar(
        title: 'setState全局刷新',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('You have pushed the button this many times:'), Text('${_counter}'), BottomView()],
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
    return Container(
      child: Text('我一直被刷新啦，可以优化我的'),
    );
  }
}
