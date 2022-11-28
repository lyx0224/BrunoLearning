import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class MyTabContent extends StatefulWidget {
  MyTabContent({Key? key}) : super(key: key);

  @override
  State<MyTabContent> createState() => _MyTabContentState();
}

class _MyTabContentState extends State<MyTabContent> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [_createQiaoFangTab(), Divider(), _createQiaoFangTabScroll()],
    );
  }

  _createQiaoFangTab() {
    var tabs = <BadgeTab>[];
    tabs.add(BadgeTab(text: '业务一'));
    tabs.add(BadgeTab(text: '业务二'));
    var tabController = TabController(length: tabs.length, vsync: this);
    return BrnTabBar(
      tabs: tabs,
      controller: tabController,
      backgroundcolor: Colors.yellow,
      onTap: (state, index) {},
      indicatorPadding: EdgeInsets.symmetric(vertical: 10),
    );
  }

  _createQiaoFangTabScroll() {
    var tabs = <BadgeTab>[];
    tabs.add(BadgeTab(text: '可滚动'));
    tabs.add(BadgeTab(text: '业务二'));
    tabs.add(BadgeTab(text: '业务三'));
    tabs.add(BadgeTab(text: '业务四'));
    tabs.add(BadgeTab(text: '业务五'));
    tabs.add(BadgeTab(text: '业务六'));
    var tabController = TabController(length: tabs.length, vsync: this);
    return BrnTabBar(tabs: tabs, controller: tabController, onTap: (state, index) {});
  }
}
