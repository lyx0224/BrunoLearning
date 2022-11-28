import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class DialogQfDemo extends StatefulWidget {
  const DialogQfDemo({Key? key}) : super(key: key);

  @override
  State<DialogQfDemo> createState() => _DialogQfDemoState();
}

class _DialogQfDemoState extends State<DialogQfDemo> {
  var themeData = BrnDialogConfig(mainActionTextStyle: BrnTextStyle.withStyle(TextStyle(color: Colors.orange)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: "巧房风格的对话框",
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BrnNormalButton(
              text: '无标题、信息 、单按钮',
              onTap: () {
                BrnDialogManager.showSingleButtonDialog(context, themeData: themeData, barrierDismissible: false, label: "知道了", message: "我是内容区域，点外部不会消失",
                    onTap: () {
                  BrnToast.show('知道了', context);
                  Navigator.pop(context);
                });
              },
            ),
            Divider(),
            BrnNormalButton(
              text: '标题、信息、单按钮',
              onTap: () {
                BrnDialogManager.showSingleButtonDialog(context, themeData: themeData, title: '标题', label: "知道了", message: "我是内容区域，默认点外部会消失", onTap: () {
                  BrnToast.show('知道了', context);
                  Navigator.pop(context);
                });
              },
            ),
            Divider(),
            BrnNormalButton(
              text: '标题、信息、双按钮',
              onTap: () {
                BrnDialogManager.showConfirmDialog(context,
                    themeData: themeData, title: "确定关注我吗？", cancel: '取消', confirm: '确定', message: "辅助内容信息辅助内容信息辅助内容信息辅助内容信息辅助内容信息", onConfirm: () {
                  BrnToast.show("确定", context);
                }, onCancel: () {
                  BrnToast.show("取消", context);
                  Navigator.pop(context);
                });
              },
            ),
            Divider(),
            BrnNormalButton(
              text: '标题、信息、三按钮',
              onTap: () {
                BrnDialogManager.showMoreButtonDialog(context,
                    title: "确定关注我吗？",
                    themeData: themeData,
                    actions: [
                      '选项一',
                      '选项二',
                      '选项三',
                    ],
                    message: "辅助内容信息辅助内容信息辅助内容信息辅助内容信息辅助内容信息", indexedActionClickCallback: (index) {
                  BrnToast.show("$index", context);
                });
              },
            ),
            Divider(),
            BrnNormalButton(
              text: '自定义内容',
              onTap: () {
                BrnDialogManager.showSingleButtonDialog(context,
                    themeData: themeData,
                    label: "OK",
                    messageWidget: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            '自定义内容',
                            style: themeData.contentTextStyle.generateTextStyle(),
                          ),
                          Image.asset(
                            'assets/image/no_data.png',
                            width: double.infinity,
                            height: 200,
                          ),
                        ],
                      ),
                    ), onTap: () {
                  Navigator.pop(context);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
