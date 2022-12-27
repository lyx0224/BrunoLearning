import 'package:bruno/bruno.dart';
import 'package:example/sample/liyixin/provider/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 购物车页面

class MyCartPage extends StatelessWidget {
  const MyCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();
    return Scaffold(
      appBar: BrnAppBar(
        title: '我的购物车',
        actions: [
          TextButton(
              onPressed: () {
                Provider.of<CartModel>(context, listen: false).removeAll();
              },
              child: Text('clearAll'))
        ],
      ),
      body: Column(
        children: [
          Consumer<CartModel>(
            builder: (context, cart, child) => Text('total: ${cart.totalPrice}'),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text('${cart.items[index].name}'),
                  trailing: TextButton(
                    //移除购物车
                      onPressed: () {
                        cart.remove(cart.items[index]);
                      },
                      child: Text('Remove')),
                )),
          ),
        ],
      ),
    );
  }
}
