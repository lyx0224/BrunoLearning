import 'package:bruno/bruno.dart';
import 'package:example/main.dart';
import 'package:example/sample/liyixin/rich_text_demo.dart';
import 'package:flutter/material.dart';

///
/// https://docs.flutter.dev/cookbook/design/snackbars
///
///
/// 必须在Scaffold里使用
///
/// MaterialApp 的child是 ScaffoldMessenger！！
///
///ScaffoldMessenger 的child 是 InheritedWidget
///
/// 可以改造成toast, 好处是：后者的toast不会被覆盖，必须在Scaffold里使用
///
///
class SnackBarDemo extends StatelessWidget {
  const SnackBarDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: 'snack bar',
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    (KeyStore.scaffoldKey.currentState as ScaffoldMessengerState).showSnackBar(
                      SnackBar(
                        content: Text('我不依赖Context'),
                      ),
                    );
                  },
                  child: Text('show without context')),
              TextButton(
                  onPressed: () {
                    ScaffoldToast.show(context, '内容可多可少');
                  },
                  child: Text(
                    'snackbar改造成taost',
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RichTextDemo()),
                    );
                  },
                  child: Text('跳转新页面，snackbar 不会消失'))
            ],
          ),
        ),
      ),
    );
  }
}

class ScaffoldToast {
  static show(BuildContext context, String text, {bool long = false}) {
    const padding = EdgeInsets.symmetric(vertical: 14, horizontal: 24);
    var textPainter = TextPainter(text: TextSpan(text: text, style: TextStyle(fontSize: 14.0)), maxLines: 1, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    var screen = MediaQuery.of(context).size.width;
    var horizontal = (screen - textPainter.size.width - padding.left - padding.right) / 2;
    if (horizontal < 24) horizontal = 24;

    final snackBar = SnackBar(
      content: Text(
        text,
        style: TextStyle(fontSize: 14),
      ),
      behavior: SnackBarBehavior.floating,
      padding: padding,
      elevation: 6,
      duration: long ? Duration(milliseconds: 3500) : Duration(milliseconds: 2000),
      margin: EdgeInsets.symmetric(vertical: 50, horizontal: horizontal),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
