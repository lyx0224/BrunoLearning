import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class ExceptionDemo extends StatefulWidget {
  const ExceptionDemo({Key? key}) : super(key: key);

  @override
  State<ExceptionDemo> createState() => _ExceptionDemoState();
}

class _ExceptionDemoState extends State<ExceptionDemo> {
  final Key key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: '异常捕获',
      ),
      body: Column(
        children: [
          Text(
            'App层异常捕获',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('========同步异常========='),
          TextButton(
            onPressed: () {
              /// try catch 捕获同步异常
              try {
                throw StateError('This is Dart Exception');
              } catch (e) {
                print(e);
              }
            },
            child: Text('点我崩溃，自己处理try catch'),
          ),
          TextButton(
            onPressed: () {
              throw StateError('This is Dart Exception');
            },
            child: Text('点我崩溃，自己不处理。FlutterError.onError统一处理，页面无异常'),
          ),
          Divider(),
          Text('========异步异常========='),
          TextButton(
            onPressed: () {
              Future.delayed(Duration(seconds: 1)).then((value) => throw StateError('错误了')).catchError((e) {
                print(e);
              });
            },
            child: Text('点我触发异步异常，自己处理了(catchError，只是打印了 错误了)，也走进Zone了（未体现出自己的代码）'),
          ),
          TextButton(
            onPressed: () {
              try {
                Future.delayed(Duration(seconds: 1)).then((value) => throw StateError('错误了'));
              } catch (e) {
                print(e);
              }
            },
            child: Text('try catch异步异常，但是catch不到！，走进Zone了（堆栈信息体现出自己的代码）'),
          ),
          Text('总结：App层的同步异常，加try catch后，自己处理；如果自己不加try catch，交给FlutterError.onError。\n'
              '异步异常，try catch捕获不到，需要catchError捕获，都统一走Zone捕获异常\n '
              '页面展示无异常！'),
          Text(
            'Framework层异常捕获',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
              'framework层异常往往是错误的使用代码，造成底层的异常判断引起的,当出现Framework异常时，最终会显示一个异常界面(通过ErrorWidget实现)，通过FlutterError类来集中处理，默认情况下，Flutter会自动弹出一个错误界面(开发模式下为红色的错误界面，relase模式下为一个灰色界面,'
              '不会产生App的崩溃！'),
          SizedBox(
            height: 10,
          ),
          Text(
            'debug下提示越界，release下截取了，页面无异常',
            style: TextStyle(color: Colors.red),
          ),
          Row(
            children: [
              Icon(Icons.nature_sharp),
              Text('太长了太长了太长了太长了太长了太长了太长了太长了太长了太长了太长了太长了太长了太长了太长了太长了太长了太长了'),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'debug下红色错误页面，太尴尬，release下，纯黑的页面，跟乌鸦一样黑',
            style: TextStyle(color: Colors.red),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => DuplicatedKeyErrorPage(),
                ));
              },
              child: Text('相同key，模拟红色的错误页面(全屏)')),
          SizedBox(
            height: 10,
          ),
          Text(
            '局部页面异常：debug下局部是红色错误页。release下错误部分是白色！',
            style: TextStyle(color: Colors.red),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => PartRedErrorPage(),
                ));
              },
              child: Text('局部红色错误页面')),
        ],
      ),
    );
  }
}

class DuplicatedKeyErrorPage extends StatelessWidget {
  DuplicatedKeyErrorPage({Key? key}) : super(key: key);

  final Key key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text('1', key: key), Text('2', key: key)],
    );
  }
}

/// 局部红色的错误页面
class PartRedErrorPage extends StatelessWidget {
  const PartRedErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [NoErrorPage(), DuplicatedKeyErrorPage()],
      ),
    );
  }
}

class NoErrorPage extends StatelessWidget {
  const NoErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 100,
      color: Colors.orange,
      child: Text('正常的'),
    );
  }
}
