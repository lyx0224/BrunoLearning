import 'package:bruno/bruno.dart';
import 'package:example/sample/home/home.dart';
import 'package:example/sample/liyixin/provider/cart_model.dart';
import 'package:example/sample/liyixin/provider/catalog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        title: 'Flutter Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
