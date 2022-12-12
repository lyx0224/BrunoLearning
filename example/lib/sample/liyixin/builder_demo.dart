import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

///
/// http://laomengit.com/flutter/widgets/Builder.html#builder
///
/// 不用Builder包一层就好了？？
///
class BuilderDemo extends StatelessWidget {
  const BuilderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: 'Builder的意义',
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              final snackBar = SnackBar(content: Text('我是snackBar'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: Text('show SnackBar')),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            _showOverlay(context);
          },
          child: Text('showOverLay')),
    );
  }

  //不会自动消失
  _showOverlay(BuildContext context) {
    final overLayState = Overlay.of(context);
    final overLayEntry = OverlayEntry(builder: (ctx) => Text('toast'));
    overLayState?.insert(overLayEntry);
  }
}
