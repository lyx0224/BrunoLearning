import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



/// 区分 showDialog
class LoadingDialogDemo extends StatelessWidget {
  const LoadingDialogDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //对话框的宽高是150

    var padding = (MediaQuery.of(context).size.width - 150) / 2;
    return Scaffold(
      appBar: BrnAppBar(
        title: 'loading',
      ),
      body: Center(
        child: Dialog(
          elevation: 8,
          insetPadding: EdgeInsets.only(left: padding, right: padding),
          backgroundColor: Colors.white,
          child: SizedBox(
            width: 150,
            height: 150,
            child: CupertinoActivityIndicator(),
          ),
        ),
      ),
    );
  }
}
