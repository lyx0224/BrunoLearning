import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//系统自带的Material风格下拉刷新
class RefreshIndicatorDemo extends StatefulWidget {
  const RefreshIndicatorDemo({Key? key}) : super(key: key);

  @override
  State<RefreshIndicatorDemo> createState() => _RefreshIndicatorDemoState();
}

class _RefreshIndicatorDemoState extends State<RefreshIndicatorDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: 'Material下拉刷新组件',
      ),
      body: RefreshIndicator(
          child: ListView.builder(
              itemCount: 50,
              itemBuilder: (context, index) => ListTile(
                    title: Text('${index + 1}'),
                  )),
          onRefresh: () async {
            BrnToast.show('refresh', context);
          }),
    );
  }
}
