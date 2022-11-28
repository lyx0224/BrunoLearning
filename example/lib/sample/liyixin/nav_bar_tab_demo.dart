import 'package:bruno/bruno.dart';
import 'package:example/sample/liyixin/tab_content_gex.dart';
import 'package:example/sample/liyixin/tab_content_rcv_gex.dart';
import 'package:flutter/material.dart';

class NavBarTabDemo extends StatefulWidget {
  const NavBarTabDemo({Key? key}) : super(key: key);

  @override
  State<NavBarTabDemo> createState() => _NavBarTabDemoState();
}

class _NavBarTabDemoState extends State<NavBarTabDemo> with SingleTickerProviderStateMixin {
  List<BadgeTab> tabs = <BadgeTab>[];
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabs.add(BadgeTab(text: "巧房1"));
    tabs.add(BadgeTab(text: "巧房2"));
    tabController = TabController(length: tabs.length, vsync: this);
  }

  /// 导航栏默认高度44，造成BrnTabBar的indicator显示不出来，
  /// 解决方案1：修改indicator和tab文字的padding来解决;
  /// 解决方案2：通过themeData修改bar的高度，[BrnAppBar.themeData] , themeData: BrnAppBarConfig(appBarHeight: 50)
  @override
  Widget build(BuildContext context) {
    // BrnTabBar
    return Scaffold(
      appBar: BrnAppBar(
        themeData: BrnAppBarConfig(appBarHeight: 50),
        leading: BrnBackLeading(
          child: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: BrnTabBar(
          tabs: tabs,
          controller: tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.orange,
          indicatorWidth: 20,
          indicatorWeight: 3,
          onTap: (state, index) {
            BrnToast.show("点击了", context);
          },
        ),
      ),
      body: TabBarView(
        children: <Widget>[MyTabContent(), MyTabContent2()],
        controller: tabController,
      ),
    );
  }
}
