import 'dart:async';

import 'package:example/sample/liyixin/rounded_loading_button.dart';
import 'package:flutter/material.dart';

/// RoundedLoadingButton 使用了rxdart
/// 设计思想，button枚举几个状态，到更新某个状态的时候，把数据加入到stream中，streambuilder更新ui
/// 动态切换ui使用了AnimatedSwitcher
/// 一个stream只能监听一次，把 RoundedLoadingButton的streamstate的状态添加到controller里,这样就可以在外部监听到stream了
class Stream3Demo extends StatefulWidget {
  const Stream3Demo({Key? key}) : super(key: key);

  @override
  State<Stream3Demo> createState() => _Stream3DemoState();
}
typedef TestFunction = String Function(String);

class _Stream3DemoState extends State<Stream3Demo> {
  final RoundedLoadingButtonController _btnController1 = RoundedLoadingButtonController();

  final RoundedLoadingButtonController _btnController2 = RoundedLoadingButtonController();

  /// 10s后success
  void _doSomething(RoundedLoadingButtonController controller) async {
    Timer(Duration(seconds: 10), () {
      controller.success();
    });
  }

  @override
  void initState() {
    super.initState();
    // _btnController1.stateStream.listen((value) {
    //   print(value);
    // });

    var result = _test("1", fun);
  }

  String fun(String s){
    return s;
  }

  /// 还可以这样定义方法
  static String Function() _test(String a, TestFunction function) => (){
    var b = function(a);
    return b;
};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Rounded Loading Button Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RoundedLoadingButton(
                successIcon: Icons.cloud,
                failedIcon: Icons.cottage,
                child: Text('Tap me!', style: TextStyle(color: Colors.white)),
                controller: _btnController1,
                onPressed: () => _doSomething(_btnController1),
              ),
              SizedBox(
                height: 50,
              ),
              RoundedLoadingButton(
                color: Colors.amber,
                successColor: Colors.amber,
                controller: _btnController2,
                onPressed: () => _doSomething(_btnController2),
                valueColor: Colors.black,
                borderRadius: 10,
                child: Text('''
Tap me i have a huge text''', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(
                height: 50,
              ),
              OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                  ),
                  onPressed: () {
                    _btnController1.reset();
                    _btnController2.reset();
                  },
                  child: Text('Reset')),
              SizedBox(
                height: 20,
              ),
              OutlinedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                ),
                onPressed: () {
                  _btnController1.error();
                  _btnController2.error();
                },
                child: Text('Error'),
              ),
              SizedBox(
                height: 20,
              ),
              OutlinedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                ),
                onPressed: () {
                  // _btnController1.success();
                  // _btnController2.success();
                  // _btnController1
                  print(_btnController1.currentState);
                },
                child: Text('Success'),
              )
            ],
          ),
        ));
  }
}
