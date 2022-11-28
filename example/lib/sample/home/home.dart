import 'package:bruno/bruno.dart';
import 'package:example/sample/home/card_data_config.dart';
import 'package:example/sample/home/group_card.dart';
import 'package:flutter/material.dart';

/// 主页面
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: 'UI组件',
        leading: null,
        automaticallyImplyLeading: false,
      ),
      body: _buildBodyWidget(context),
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    List<GroupInfo> list = CardDataConfig.getAllGroup();
    DateTime? _lastPressedAt;
    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 1)) {
          _lastPressedAt = DateTime.now();
          BrnToast.show('double back to quit', context);
          return false;
        }
        return true;
      },
      child: Container(
          color: Color(0xFFF8F8F8),
          padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.only(top: 10),
                  child: GroupCard(
                    groupInfo: list[index],
                  ),
                );
              })),
    );
  }
}
