import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class OffStageAndVisibleDemo extends StatefulWidget {
  const OffStageAndVisibleDemo({Key? key}) : super(key: key);

  @override
  State<OffStageAndVisibleDemo> createState() => _OffStageAndVisibleDemoState();
}

/// Visibility 组件实现INVISIBLE效果
///  visible: false,
//   maintainAnimation: true,
//   maintainState: true,
//   maintainSize: true
///
///
class _OffStageAndVisibleDemoState extends State<OffStageAndVisibleDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: 'Flutter如何隐藏控件？',
      ),
      body: Container(
        color: Colors.red.shade50,
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              color: Colors.red,
            ),
            Offstage(
              offstage: false,
              child: Container(
                width: 50,
                height: 50,
                child: Text('类似AndroidGone', style: TextStyle(fontSize: 10)),
                color: Colors.yellow,
              ),
            ),
            Visibility(
              visible: true,
              child: Container(
                width: 50,
                height: 50,
                child: Text(
                  'visible=false跟OffStage一样',
                  style: TextStyle(fontSize: 10),
                ),
                color: Colors.orange,
              ),
            ),
            Visibility(
              visible: false,
              maintainAnimation: true,
              maintainState: true,
              maintainSize: true,
              child: Container(
                width: 50,
                height: 50,
                child: Text('实现INVISIBLE需要多点属性', style: TextStyle(fontSize: 10)),
                color: Colors.grey,
              ),
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.blueAccent,
            )
          ],
        ),
      ),
    );
  }
}
