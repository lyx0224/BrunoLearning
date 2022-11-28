import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
//学习一下基础的语法。
class ComponentStyle {
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  EdgeInsets? padding;

  //右键 -> generate -> Constructor
  ComponentStyle({this.color, this.fontSize, this.fontWeight, this.padding});

  ComponentStyle copyWith({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    EdgeInsets? padding,
  }) {
    return ComponentStyle(
      color: color ?? this.color,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      padding: padding ?? this.padding,
    );
  }

  ComponentStyle merge(ComponentStyle? other) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      fontSize: other.fontSize,
      fontWeight: other.fontWeight,
      padding: other.padding,
    );
  }
}

/// 构造器赋值的写法

//1、这种写法适用于extends的时候，适用于private(下划线)变量
class BrnAppBarConfig extends BrnBaseConfig {
  BrnAppBarConfig({
    double? appBarHeight,
  })  : _appBarHeight = appBarHeight,
        super(configId: "");

  double? _appBarHeight;

  double get appBarHeight => _appBarHeight ?? BrnDefaultConfigUtils.defaultAppBarConfig.appBarHeight;

  //类似kotlin的set
  set appBarHeight(double? value) {
    if (appBarHeight == value) {
      return;
    }
    appBarHeight = value;
    //can do something
  }
}

//2、这种写法适用于全部都是public的字段
class BrnAppBarConfig2 {
  BrnAppBarConfig2({
    this.appBarHeight,
  });

  double? appBarHeight;
}
