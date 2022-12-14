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
            ])),
            Divider(),
            RichText(
                textAlign: TextAlign.start, //对齐方式
                text: TextSpan(children: [
                  WidgetSpan(
                      child: Icon(
                    Icons.search,
                    size: 16,
                  )),
                  TextSpan(text: '图文混排图文混排图文混排图文混排图文混排图文混排图文混排图文混排图文混。', style: TextStyle(color: Colors.blueAccent)),
                  TextSpan(text: '文本的style必须设置，否则不可见', style: TextStyle(color: Colors.redAccent)),
                ])),
            Divider(),
            RichText(
                text: TextSpan(children: [
              WidgetSpan(
                  child: ElevatedButton(
                      onPressed: () {
                        BrnToast.show('click', context);
                      },
                      child: Text('button'))),
              TextSpan(text: '也可以自由widget拼接', style: TextStyle(color: Colors.orange)),
            ])),
            Divider(),
            Text(
              'hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
