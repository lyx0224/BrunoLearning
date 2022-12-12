

import 'package:bruno/bruno.dart';
import 'package:example/sample/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //全局配置
    BrnInitializer.register(
      allThemeConfig: BrnAllThemeConfig(
        dialogConfig: BrnDialogConfig(radius: 10),
        commonConfig: BrnCommonConfig(brandPrimary: Color(0xFF3072F6))
      )
    );
    return MaterialApp(
      title: 'Flutter Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
