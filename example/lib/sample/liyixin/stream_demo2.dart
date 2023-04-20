import 'dart:async';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

/// 如果再次监听了，StreamBuilder不会监听到了，但不报错！
class StreamDemo2 extends StatefulWidget {
  const StreamDemo2({Key? key}) : super(key: key);

  @override
  State<StreamDemo2> createState() => _StreamDemo2State();
}

class _StreamDemo2State extends State<StreamDemo2> {
  final List<int> _numbers = [];
  late StreamController<List<int>> _streamController;

  Stream<List<int>> get _stream => _streamController.stream;
  late StreamSubscription _dataSubscription;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<int>>();
    addNumbers();
    /// 如果再次监听了，StreamBuilder不会监听到了，但不报错！
    // _dataSubscription = _stream.listen((event) {
    //   print(event);
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
    // _dataSubscription.cancel();
  }

  void addNumbers() async {
    // 一共5次
    for (int i = 0; i < 25; i++) {
      _numbers.add(i);
      // 每加入5个数便将其添加到Stream中，ui更新。
      if (_numbers.length % 5 == 0) {
        // 每次向管道里追加5个数组，记住是追加。
        _streamController.sink.add(_numbers);
      }

      await Future.delayed(Duration(milliseconds: 500));
    }
    _streamController.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: '数据流(持续的)',
      ),
      body: Center(
        child: StreamBuilder<List<int>>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
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
    );
  }
}
