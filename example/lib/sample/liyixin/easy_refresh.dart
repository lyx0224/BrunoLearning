import 'dart:math';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

///
/// 下拉刷新、上拉加载
///
/// 更多demo参考BKFlutterWidget
///
class EasyRefreshDemo extends StatefulWidget {
  const EasyRefreshDemo({Key? key}) : super(key: key);

  @override
  State<EasyRefreshDemo> createState() => _EasyRefreshDemoState();
}

class _EasyRefreshDemoState extends State<EasyRefreshDemo> {
  int _count = 10;
  late EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: '上拉加载下拉刷新',
      ),
      floatingActionButton: BrnNormalButton(
        text: '下拉刷新',
        onTap: () => _controller.callRefresh(),
      ),
      body: EasyRefresh(
          emptyWidget: _count == 0
              ? Container(
                  alignment: Alignment.center,
                  color: Colors.orange,
                  child: Text('空视图'),
                )
              : null,
          controller: _controller,
          header: ClassicalHeader(),
          footer: ClassicalFooter(),
          onRefresh: () async {
            BrnToast.show('onRefresh', context);
            await Future.delayed(Duration(seconds: 3));
            if (mounted) {
              setState(() {
                //Value is >= 0 and < 10
                var intValue = Random().nextInt(10);
                print('random: $intValue');
                if (intValue > 5) {
                  _count = 0;
                } else {
                  _count = 10;
                }
              });
              _controller.finishRefresh(success: true);
              _controller.finishLoad(noMore: _count >= 20);
            }
          },
          onLoad: () async {
            BrnToast.show('onLoad', context);
            await Future.delayed(Duration(seconds: 3));
            if (mounted) {
              setState(() {
                _count += 5;
              });
              var noMore = _count >= 20;
              _controller.finishLoad(noMore: noMore);
            }
          },
          child: ListView.builder(
              itemCount: _count,
              itemBuilder: (ctx, index) => Card(
                    child: Container(
                      alignment: Alignment.center,
                      height: 80,
                      child: Text('${index + 1}'),
                    ),
                  ))),
    );
  }
}
