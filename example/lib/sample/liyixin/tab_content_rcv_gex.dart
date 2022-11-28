import 'package:example/sample/liyixin/nav_bar_tab_demo.dart';
import 'package:flutter/material.dart';

class MyTabContent2 extends StatefulWidget {
  const MyTabContent2({Key? key}) : super(key: key);

  @override
  State<MyTabContent2> createState() => _MyTabContent2State();
}

class _MyTabContent2State extends State<MyTabContent2> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('content2'),
    );
  }
}
