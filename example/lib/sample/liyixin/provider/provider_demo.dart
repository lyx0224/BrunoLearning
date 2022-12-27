import 'package:bruno/bruno.dart';
import 'package:example/sample/liyixin/provider/cart_model.dart';
import 'package:example/sample/liyixin/provider/my_cart_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'catalog.dart';

/// 品类页面
///
/// Provider状态管理的使用
///
/// provider: ^6.0.5
///
/// ChangeNotifierProvider在main.dart声明
///

class ProviderDemo extends StatelessWidget {
  const ProviderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final len = context.select<CatalogModel, int>((cataLog) => cataLog.cataLen);
    return Scaffold(
      appBar: BrnAppBar(
        title: '类别页面',
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyCartPage()));
              },
              child: Text('购物车'))
        ],
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) => _ListItem(index: index),
        itemCount: len,
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  _ListItem({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    var item = context.select<CatalogModel, Item>(
      // Here, we are only interested in the item at [index]. We don't care
      // about any other change.
      (catalog) => catalog.getByPosition(index),
    );
    return Row(
      children: [
        Expanded(child: Text('${item.name}')),
        _AddButton(item: item),
      ],
    );
  }
}

class _AddButton extends StatelessWidget {
  _AddButton({Key? key, required this.item}) : super(key: key);
  final Item item;

  @override
  Widget build(BuildContext context) {
    // The context.select() method will let you listen to changes to
    // a *part* of a model. You define a function that "selects" (i.e. returns)
    // the part you're interested in, and the provider package will not rebuild
    // this widget unless that particular part of the model changes.
    //
    // This can lead to significant performance improvements.
    var isInCart = context.select<CartModel, bool>(
      // Here, we are only interested whether [item] is inside the cart.
      (cart) => cart.items.contains(item),
    );
    return TextButton(
      onPressed: isInCart
          ? null
          : () {
              //添加
              var cart = context.read<CartModel>();
              cart.add(item);
            },
      child: isInCart ? Icon(Icons.check) : Text('Add Me'),
    );
  }
}
