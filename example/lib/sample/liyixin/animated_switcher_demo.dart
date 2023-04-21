import 'package:flutter/material.dart';

/// 要有不同的key
class AnimatedSwitcherDemo extends StatefulWidget {
  const AnimatedSwitcherDemo({Key? key}) : super(key: key);

  @override
  State<AnimatedSwitcherDemo> createState() => _AnimatedSwitcherDemoState();
}

class _AnimatedSwitcherDemoState extends State<AnimatedSwitcherDemo> {
  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(onPressed: () {
            setState(() {
              toggle = !toggle;
            });
          }, child: Text('toggle')),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: toggle
                ? Container(
              key: UniqueKey(),
              width: 100,
              height: 100,
              color: Colors.red,
            )
                : Container(
              key: UniqueKey(),
              width: 50,
              height: 50,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
