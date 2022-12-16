import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//系统自带的Material风格下拉刷新
class RefreshIndicatorWithScrollViewDemo extends StatefulWidget {
  const RefreshIndicatorWithScrollViewDemo({Key? key}) : super(key: key);

  @override
  State<RefreshIndicatorWithScrollViewDemo> createState() => _RefreshIndicatorWithScrollViewDemoState();
}

class _RefreshIndicatorWithScrollViewDemoState extends State<RefreshIndicatorWithScrollViewDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: 'Material下拉刷新组件',
      ),
      body: RefreshIndicator(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.red,
                  height: 100,
                  child: Text('sliverToBox'),
                ),
              ),
              SliverFixedExtentList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ListTile(
                    title: Text('item定高：${index + 1}'),
                  ),
                  childCount: 5,
                ),
                itemExtent: 50,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => Card(
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Text('${index + 1}'),
                            color: Colors.orange,
                          ),
                        ),
                    childCount: 5),
              )
            ],
          ),
          onRefresh: () async {
            BrnToast.show('refresh', context);
          }),
    );
  }
}
