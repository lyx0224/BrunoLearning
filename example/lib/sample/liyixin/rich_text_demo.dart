import 'package:bruno/bruno.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextDemo extends StatefulWidget {
  const RichTextDemo({Key? key}) : super(key: key);

  @override
  State<RichTextDemo> createState() => _RichTextDemoState();
}

class _RichTextDemoState extends State<RichTextDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: '富文本',
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(text: '我是', style: TextStyle(color: Colors.red)),
              TextSpan(text: 'Ethan', style: TextStyle(color: Colors.blueAccent)),
            ])),
            Divider(),
            RichText(
                text: TextSpan(children: [
              TextSpan(text: 'xxx', style: TextStyle(color: Colors.red)),
              TextSpan(
                  text: '《点击我试试》',
                  style: TextStyle(color: Colors.blueAccent, fontStyle: FontStyle.italic),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      BrnToast.show('clicked', context);
                    }),
            ]))
          ],
        ),
      ),
    );
  }
}
