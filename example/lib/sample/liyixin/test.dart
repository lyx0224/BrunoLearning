import 'package:bruno/src/components/navbar/brn_appbar_theme.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/constants/brn_strings_constants.dart';
import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_default_config_utils.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef BrnWidgetBuilder = Widget Function();


//这种写法适用于extends的时候
class BrnAppBarConfig extends BrnBaseConfig {
  BrnAppBarConfig({
    double? appBarHeight,
  })  : _appBarHeight = appBarHeight,
        super(configId: "");

  /// AppBar 的高度
  double? _appBarHeight;

  double get appBarHeight => _appBarHeight ?? BrnDefaultConfigUtils.defaultAppBarConfig.appBarHeight;
}

//这种写法适用于全部都是public的字段
class BrnAppBarConfig2 {
  BrnAppBarConfig2({
    this.appBarHeight,
  });

  double? appBarHeight;
}
