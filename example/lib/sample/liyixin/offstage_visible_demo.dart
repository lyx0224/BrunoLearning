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
      body: Column(
        children: [
          Container(
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
          Divider(),
          Text('学习下Container的constraints属性：'),
          Container(
            color: Colors.blue,
            child: Text('maxWidth:100\nmaxHeight:50'),
            constraints: BoxConstraints.tightFor(width: 100, height: 50),
          ),
          Container(
            color: Colors.amber,
            child: Text('maxW=minW \n maxH=minH'),
            constraints: BoxConstraints.expand(width: 100, height: 50),
          ),
          Expanded(
            child: Container(
              color: Colors.red.withOpacity(0.3),
              child: Text('此时宽高是无穷大，收到父View宽高的限制\n 在Column中需要套一层Expand组件，否则报错：BoxConstraints forces an infinite height'),
              constraints: BoxConstraints.expand(),
            ),
          )
        ],
      ),
    );
  }
}
