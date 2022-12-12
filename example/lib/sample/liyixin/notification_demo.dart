import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class NotificationDemo extends StatefulWidget {
  const NotificationDemo({Key? key}) : super(key: key);

  @override
  State<NotificationDemo> createState() => _NotificationDemoState();
}

//http://laomengit.com/flutter/widgets/NotificationListener.html#notificationlistener

//https://api.flutter.dev/flutter/widgets/NotificationListener-class.html
//具有滚动熟悉的widget比如ListView会分发Scroll的通知，如果想要收到通知，套一层NotificationListener即可获取到。
class _NotificationDemoState extends State<NotificationDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: 'Notification事件传递',
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          //滚动了多少
          print('scroolY: ${notification.metrics.pixels}, 方向:${notification.metrics.axisDirection.name}');
          //返回true代表不再向上传递。
          return true;
        },
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('index:$index'),
            );
          },
          itemCount: 100,
        ),
      ),
    );
  }
}
