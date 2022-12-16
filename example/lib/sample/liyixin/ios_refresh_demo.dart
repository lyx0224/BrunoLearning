import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IOSRefreshDemo extends StatefulWidget {
  const IOSRefreshDemo({Key? key}) : super(key: key);

  @override
  State<IOSRefreshDemo> createState() => _IOSRefreshDemoState();
}

class _IOSRefreshDemoState extends State<IOSRefreshDemo> {
  var _list = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    /// 没有效果！！
    ///
    /// CupertinoSliverRefreshControl的用法和RefreshIndicator不同，CupertinoSliverRefreshControl需要放在CustomScrollView中
    ///
    ///
    return Scaffold(
      appBar: BrnAppBar(
        title: 'iOS风格自带的下拉刷新',
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              setState(() {
                _list.add(_list.length + 1);
              });
            },
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => ListTile(
                        title: Text('${index + 1}'),
                      ),
                  childCount: _list.length))
        ],
      ),
    );
  }
}
