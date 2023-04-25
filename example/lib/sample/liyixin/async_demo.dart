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
                await httpWithError(2, 'getDetail').catchError((e) {
                  print('1、错误了，会走到这一步');
                });
                BrnToast.show("下一步不会走到了（容易忽略）", context);
              },
              child: Text(
                '【一般不会await和catchError一起使用】await catchError 不try catch',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                /// 走进了runZonedGuarded 。后续的toast没走到
                httpWithError(2, 'getDetail').then((value) {
                  print('出错了不会走到这里');
                }).catchError((e) {
                  print('2、错误了，会走到这一步');
                });
                BrnToast.show("1、先走这一步", context);
              },
              child: Text(
                '【重要 不用await】用then和catchError ',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await httpWithError(2, 'getDetail');
                } catch (e, stack) {
                  print('1、我会走到的');
                }
                BrnToast.show("2、这一步会走到", context);
              },
              child: Text(
                '【重要 常用】try catch 异步异常',
              ),
            ),
            TextButton(
              onPressed: () async {
                List results = await Future.wait([
                  http(1, 'getId'),
                  httpWithError(2, 'getDetail'),
                ]).catchError((e) {
                  BrnToast.show('1、Error啦', context);
                });
                String msg = "${results[0]}, ${results[1]}";
                BrnToast.show("这一步没走到：${msg}", context);
              },
              child: Text(
                '【一般await和catchError不一起使用】await并行（catchError 不try catch）',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () async {
                dynamic result;
                try {
                  result = await Future.wait([
                    http(1, 'getId'),
                    httpWithError(2, 'getDetail'),
                  ]);
                } catch (e, stack) {
                  print('1、会走到');
                }
                BrnToast.show("2、会走到}", context);
              },
              child: Text(
                '【重要】await并行（try catch）',
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
