import 'dart:async';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

/// stream被监听多次！！
/// stream被StreamBuilder监听了，还可以额外的监听。
/// 如果是系统的StreamController，如果额外监听，那么StreamBuilder不生效。
class StreamDemo2_1 extends StatefulWidget {
  const StreamDemo2_1({Key? key}) : super(key: key);

  @override
  State<StreamDemo2_1> createState() => _StreamDemo2State();
}

class _StreamDemo2State extends State<StreamDemo2_1> {
  final List<int> _numbers = [];
  /// 默认值是空数组，在StreamBuilder里要判断length=0 不能判断为空了，否则没有loading
  final BehaviorSubject<List<int>> _controllerState = BehaviorSubject<List<int>>.seeded([]);

  int length = 0;

  late StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();
    addNumbers();
    /// 多次监听！！
    _streamSubscription = _controllerState.stream.listen((event) {
      setState(() {
        length = event.length;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
    _controllerState.close();
  }

  void addNumbers() async {
    // 一共5次
    for (int i = 0; i < 25; i++) {
      _numbers.add(i);
      // 每加入5个数便将其添加到Stream中，ui更新。
      if (_numbers.length % 5 == 0) {
        // 每次向管道里追加5个数组，记住是追加。
        _controllerState.sink.add(_numbers);
      }

      await Future.delayed(Duration(milliseconds: 500));
    }
    _controllerState.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: '多次监听(2_1)',
      ),
      body: Column(
        children: [
          Text("length : $length"),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: StreamBuilder<List<int>>(
                stream: _controllerState,// 注意不是：_controllerState.stream
                builder: (context, snapshot) {
                  if (snapshot.data?.length == 0) {
                    return CircularProgressIndicator();
                  }
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) => ListTile(
                            title: Text('Number ${snapshot.data?[index]}'),
                          ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
