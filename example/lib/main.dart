import 'dart:async';

import 'package:bruno/bruno.dart';
import 'package:example/sample/home/home.dart';
import 'package:example/sample/liyixin/provider/cart_model.dart';
import 'package:example/sample/liyixin/provider/catalog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (kReleaseMode) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    } else {
      FlutterError.dumpErrorToConsole(details);
    }
  };

  runZonedGuarded<Future<void>>(() async {
    runApp(MyApp());
  }, (Object error, StackTrace s) {
    _nativeReportCrash(error, s);
  });
}

_nativeReportCrash(dynamic e, dynamic stackTrace) async {
  if (!kReleaseMode) {
    print("============================START================================");
    print(e);
    print("stack below :\n");
    print(stackTrace);
    print("============================END==================================");
    return;
  }
}

class KeyStore {
  static late GlobalKey scaffoldKey;
}


class MyApp extends StatelessWidget {

  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    KeyStore.scaffoldKey = _scaffoldKey;
    //全局配置
    BrnInitializer.register(
        allThemeConfig: BrnAllThemeConfig(dialogConfig: BrnDialogConfig(radius: 10), commonConfig: BrnCommonConfig(brandPrimary: Color(0xFF3072F6))));
    return MultiProvider(
      providers: [
        //普通的类也要？？
        Provider(create: (ctx) => CatalogModel()),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (ctx) => CartModel(),
          update: (BuildContext context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: _scaffoldKey,
        title: 'Flutter Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
