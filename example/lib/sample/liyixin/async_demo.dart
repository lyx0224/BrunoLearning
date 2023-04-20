import 'dart:async';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class AsyncDemo extends StatefulWidget {
  const AsyncDemo({Key? key}) : super(key: key);

  @override
  State<AsyncDemo> createState() => _AsyncDemoState();
}

class _AsyncDemoState extends State<AsyncDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: 'Async',
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                List results = await Future.wait([
                  http(2, "getDetail"),
                  http(3, "getInfo"),
                  http(1, "getUser"),
                ]);
                String msg = "${results[0]}, ${results[1]}, ${results[2]}";
                BrnToast.show(msg, context);
              },
              child: Text(
                '类似Rxjava zip',
                style: TextStyle(color: Colors.green),
              ),
            ),
            TextButton(
              onPressed: () async {
                String result0 = await http(2, "getDetail");
                print(result0);
                String result1 = await http(3, "getInfo");
                print(result1);
                String result2 = await http(1, "getUser");
                print(result2);
              },
              child: Text(
                '串行执行几个异步任务',
                style: TextStyle(color: Colors.green),
              ),
            ),
            TextButton(
              onPressed: () async {
                /// 走进了runZonedGuarded 。后续的toast没走到
                String result = await httpWithError(2, 'getDetail').catchError((e) {
                  BrnToast.show("错误了！！！", context);
                });
                BrnToast.show("下一步不会走到了", context);
              },
              child: Text(
                '单个出错的异步，走进了runZonedGuarded和自己的catch方法',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () async {
                List results = await Future.wait([
                  http(1, 'getId'),
                  httpWithError(2, 'getDetail'),
                ]).catchError((e) {
                  BrnToast.show('Error啦', context);
                });
                String msg = "${results[0]}, ${results[1]}";
                BrnToast.show(msg, context);
              },
              child: Text(
                '其中一个异步出错，其他异步任务也拿不到结果，但可以catch',
                style: TextStyle(color: Colors.red),
              ),
            ),
            Divider(
              height: 20,
            ),
            Text('==========微任务=========='),
            TextButton(
              onPressed: () {
                Future.microtask(() => BrnToast.show('可以把相对耗时的放在这里处理', context));
              },
              child: Text('执行一个微任务'),
            ),
            TextButton(
              onPressed: () async {
                print("A");
                await Future(() {
                  print("B");
                  Future(() => print("C"));
                  Future.microtask(() => print("D"));
                  Future(() => print("E"));
                  print("F");
                });
                print("G");
              },
              child: Text('Future、micro执行顺序，打印（ABFGDCE）'),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> http(int delay, String who) async {
    await Future.delayed(Duration(seconds: delay));
    return "我是${who}的结果";
  }

  Future<String> httpWithError(int delay, String who) {
    return Future.delayed(Duration(seconds: 1)).then((value) => throw StateError('错误了')).catchError((e) {
      return "xxx";

      /// 也不会返回xxx了
    });
  }
}
