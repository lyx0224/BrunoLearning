import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class WidgetBindingDemo extends StatefulWidget {
  const WidgetBindingDemo({Key? key}) : super(key: key);

  @override
  State<WidgetBindingDemo> createState() => _WidgetBindingDemoState();
}

class _WidgetBindingDemoState extends State<WidgetBindingDemo> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Future<bool> didPopRoute() {
    print('WidgetBindingDemo.didPopRoute');
    return super.didPopRoute();
  }

  @override
  Future<bool> didPushRoute(String route) {
    print('WidgetBindingDemo.didPushRoute: ${route}');
    return super.didPushRoute(route);
  }

  /// 前台切后台 -> inactive , paused
  /// 后台切前台 -> resumed
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('WidgetBindingDemo#didChangeAppLifecycleState:${state}');
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    final inset = MediaQuery.of(context).viewInsets;
    return Scaffold(
      appBar: BrnAppBar(
        title: 'WidgetBinding',
      ),
      body: Column(
        children: [
          Text('${inset.right}'),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => WidgetBindingDemo()));
              },
              child: Text('Push一个页面')),
        ],
      ),
    );
  }
}
