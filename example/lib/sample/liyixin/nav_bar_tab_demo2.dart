import 'package:bruno/bruno.dart';
import 'package:example/sample/liyixin/tab_content_gex.dart';
import 'package:example/sample/liyixin/tab_content_rcv_gex.dart';
import 'package:flutter/material.dart';

class NavBarTabDemo2 extends StatefulWidget {
  const NavBarTabDemo2({Key? key}) : super(key: key);

  @override
  State<NavBarTabDemo2> createState() => _NavBarTabDemoState2();
}

class _NavBarTabDemoState2 extends State<NavBarTabDemo2> with SingleTickerProviderStateMixin {
  List<BadgeTab> tabs = <BadgeTab>[];
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabs.add(BadgeTab(text: "业务一"));
    tabs.add(BadgeTab(text: "业务二"));
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        leading: BrnBackLeading(
          child: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: TabBar(
          indicator: CustomWidthUnderlineTabIndicator(
            insets: EdgeInsets.symmetric(vertical: -0),
            borderSide: BorderSide(
              width: 2,//圆角
              color: Colors.black,
            ),
          ),
          tabs: [
            Text(
              'tab1',
              style: TextStyle(color: Colors.red),
            ),
            Text('tab2', style: TextStyle(color: Colors.red))
          ],
          controller: tabController,
        ),
      ),
      body: Center(
        child: Text('可用系统的TabBar实现'),
      ),
    );
  }
}
