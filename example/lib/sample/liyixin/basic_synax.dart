import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class BasicSynaxDemo extends StatefulWidget {
  const BasicSynaxDemo({Key? key}) : super(key: key);

  @override
  State<BasicSynaxDemo> createState() => _BasicSynaxDemoState();
}

class _BasicSynaxDemoState extends State<BasicSynaxDemo> {
  /// 这样定义一个map
  Map<String, dynamic> map = {
    'key': 'empty',
    'key2': 2,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: '基础语法',
      ),
      body: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
                onPressed: () {
                  setState(() {
                    /// map 这样赋值
                    map['key'] = 'data';
                    map['key2'] = 100;
                  });
                },
                child: Text('change map')),
            TextButton(
                onPressed: () {
                  setState(() {
                    /// 这样移除一个键值对，key2的value变成了null
                    map.remove('key2');
                  });
                },
                child: Text('remove map')),
            Text('${map['key']} + ${map['key2']}'),
          ],
        ),
      ),
    );
  }

  foo() {
    final void Function() callbaclk;

    final String Function() callback2;

    final String Function(int) callback3;

    foo2(onDataFun('test'));

    /// 类似lambda表达式
    foo2((s) => null);

    foo3(onDataFun('test'));
    foo4(onDataFun('dd'));

    /// 类似lambda表达式
    foo4((p0) => null);

    // foo4(onDataFun2());

    foo5(onData: () {});
  }

  /// 方法作为参数 不用再写变量。
  foo2(void onData(String)) {}

  /// 方法作为参数 不用再写变量。
  foo5({void onData()?}) {}

  /// 不限输入和输出
  foo3(Function fun) {}

  /// 只能接受输入是String的方法
  foo4(Function(String) fun) {}

  onDataFun(String s) {}

  onDataFunc2() {}
}
