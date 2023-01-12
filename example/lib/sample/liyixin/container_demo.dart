import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class ContainerDemo extends StatefulWidget {
  const ContainerDemo({Key? key}) : super(key: key);

  @override
  State<ContainerDemo> createState() => _ContainerDemoState();
}

class _ContainerDemoState extends State<ContainerDemo> {
  final editController = TextEditingController();

  @override
  void initState() {
    editController.text = 'init';
    super.initState();
  }

  @override
  void dispose() {
    editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: 'Container',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              width: 100,
              color: Colors.blue,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              width: 100,
              alignment: Alignment.center,
              child: Text(
                'BoxDecoration 圆形',
                style: TextStyle(fontSize: 10),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.red, width: 4),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
                border: Border.all(color: Colors.red, width: 1),
              ),
              child: Text(
                'BoxDecoration 矩形，比较常用',
                style: TextStyle(fontSize: 10),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('ShapeDecoration，gradient和color不能一起设置。'),
            Container(
              height: 50,
              width: 100,
              alignment: Alignment.center,
              child: Text(
                'ShapeDecoration,适用于渐变',
                style: TextStyle(fontSize: 10),
              ),
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.orange],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                shape: RoundedRectangleBorder(),
              ),
            ),
            Divider(),
            Text('注意：enabledBorder是失焦border'),
            Text(
              '如果最外层的Column,键盘弹起的时候，内容区可能overflow，套一层滚动的即可。',
              style: TextStyle(color: Colors.red),
            ),
            TextFormField(
              controller: editController,
              maxLines: 1,
              onChanged: (value) => BrnToast.show(value, context),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.red,
                ),
                suffix: GestureDetector(
                  child: Icon(Icons.delete),
                  onTap: () {
                    editController.text = '';
                    // final text = editController.text;
                    // BrnToast.show(text, context);
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.yellow, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(hintText: '点我'),
            )
          ],
        ),
      ),
    );
  }
}
