import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class StackDemo extends StatefulWidget {
  const StackDemo({Key? key}) : super(key: key);

  @override
  State<StackDemo> createState() => _StackDemoState();
}

class _StackDemoState extends State<StackDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: 'Stack',
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.red,
                ),
                Positioned(
                    left: 20,
                    right: 20,
                    bottom: 10,
                    top: 10,
                    child: Container(
                      color: Colors.green,
                    ))
              ],
            ),
            Divider(),
            Text('修改IndexedStack的index试试'),
            IndexedStack(
              //只会展示index的Container
              index: 0,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.orange,
                )
              ],
            ),
            Divider(),
            Text('Stack.alignment营销child位置'),
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  color: Colors.red,
                  width: 100,
                  height: 100,
                ),
                Container(
                  color: Colors.yellow,
                  width: 20,
                  height: 20,
                )
              ],
            ),
            Text('Stack fit'),
            Expanded(
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.orange.withOpacity(0.5),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
