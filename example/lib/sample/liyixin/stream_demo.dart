import 'dart:async';
import 'dart:math';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class StreamDemo extends StatefulWidget {
  const StreamDemo({Key? key}) : super(key: key);

  @override
  State<StreamDemo> createState() => _StreamDemoState();
}

class _StreamDemoState extends State<StreamDemo> {
  //sync 参数默认是异步的，异步使用microEvent消息队列实现。
  StreamController<String> _dataController = StreamController<String>();

  StreamSink<String> get _dataSink => _dataController.sink;

  Stream<String> get _dataStream => _dataController.stream;
  late StreamSubscription<String> _dataSubscription;

  String _event = "";

  //streamBuilder
  StreamController<String> _streamController = StreamController<String>();

  @override
  void initState() {
    super.initState();
    //stream map
    _dataSubscription = _dataStream.map((_event) => "${_event} + tails").listen((event) {
      setState(() {
        _event = event;
      });
    }, onError: (e, stacktrace) {
      setState(() {
        _event = e;
      });
    });
  }

  @override
  void dispose() {
    _dataSubscription.cancel();
    _dataController.close();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: Text('stream基础用法'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BrnNormalButton(
                  text: '发送',
                  onTap: () {
                    _dataSink.add(Random().nextInt(10).toString());
                  },
                ),
                Text('${_event}')
              ],
            ),
            Divider(),
            Column(
              children: [
                FittedBox(
                  child: BrnNormalButton(
                    text: '发送错误(会走到onError，如果onError不处理，会走到沙盒统一处理)',
                    onTap: () {
                      _dataSink.addError('error:${Random().nextInt(10)}');
                      // _dataSink.add(Random().nextInt(10).toString());
                    },
                  ),
                ),
                Text('${_event}')
              ],
            ),
            Divider(),
            Row(
              children: [
                BrnNormalButton(
                  text: '发送2',
                  onTap: () {
                    _streamController.add(Random().nextInt(10).toString());
                  },
                ),
                StreamBuilder(
                  initialData: '我在等stream到来',
                  stream: _streamController.stream,
                  builder: (ctx, snapshot) {
                    if (snapshot.hasData) {
                      return Text('${snapshot.data}');
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
