import 'dart:math';

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

  /// 自定义notifier
  final DataBeanNotifier _dataBeanNotifier = DataBeanNotifier(DataBean('initName'));

  @override
  void dispose() {
    super.dispose();
    _counter.dispose();
  }

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
                return Text('$value');
              }),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ValueListenableBuilder<DataBean>(
                valueListenable: _dataBeanNotifier,
                builder: (context, value, child) => Text(
                      '${value.name}',
                      style: TextStyle(color: Colors.orange),
                    )),
          ),
          OtherView()
        ],
      )),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _incrementCounter();
            },
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              final random = Random().nextInt(100);
              _dataBeanNotifier.changeData('自定义ValueNotifier：李义新$random');
            },
            child: Icon(Icons.change_circle),
          ),
        ],
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

/// 你也可以继承ValueNotifier实现更复杂的。

class DataBeanNotifier extends ValueNotifier<DataBean> {
  DataBeanNotifier(DataBean value) : super(value);

  changeData(String? name) {
    value.name = name;
    notifyListeners();
  }
}

class DataBean {
  DataBean(this.name);

  String? name;
}
