import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

// Flutter裁剪系列，可以裁剪矩形，圆形，不规则图形等
//ClipRRect
//ClipOval
class ClipDemo extends StatefulWidget {
  const ClipDemo({Key? key}) : super(key: key);

  @override
  State<ClipDemo> createState() => _ClipDemoState();
}

class _ClipDemoState extends State<ClipDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: 'Clip系列',
      ),
      body: SingleChildScrollView(//类似Android ScrollView
        child: Center(
          child: Column(
            children: [
              //切割成圆角矩形
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 200,
                  height: 100,
                  alignment: Alignment.center,
                  color: Colors.orange,
                  child: Text('圆角矩形(RRect)裁剪'),
                ),
              ),
              Divider(),
              //矩形切割
              ClipRect(
                clipper: TopBarclipper(),
                child: Container(
                  width: 200,
                  height: 100,
                  alignment: Alignment.center,
                  color: Colors.orange,
                  child: Text('切个1/2'),
                ),
              ),
              Divider(),
              //圆形切割
              ClipOval(
                child: Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  color: Colors.orange,
                  child: Text('Circle'),
                ),
              ),
              Divider(),
              Stack(
                children: [
                  Container(
                    //用来对比
                    width: 100,
                    height: 100,
                    color: Colors.red.withAlpha(20),
                  ),
                  ClipPath(
                    clipper: TriangleClipper(),
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
              Divider(),
              ClipPath(
                clipper: WujiaoxingClipper(),
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
              ),
              Divider(),
              Container(//这样实现圆角也可以
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                  color: Colors.amber
                ),
                width: 100,
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}

//矩形（Rect）切割规则
class TopBarclipper extends CustomClipper<Rect> {
  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }

  @override
  getClip(Size size) {
    //child的size
    Rect rect = Rect.fromLTRB(0, 0, size.width / 2, size.height / 2);
    return rect;
  }
}

/// 切割三角形
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    //矩形的左上角为坐标原点
    Path path = Path()
      ..moveTo(0, size.height) //矩形的左下角
      ..lineTo(size.width, size.height) //矩形的右下角
      ..lineTo(size.width / 2, size.height / 2) //矩形的中间
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WujiaoxingClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var x = size.width;
    var y = size.height;
    Path path = Path()
      ..moveTo(0, y / 4) //左角
      ..lineTo(x, y / 4)
      ..lineTo(x / 4, y)
      ..lineTo(x / 2, 0) //定
      ..lineTo(x * 3 / 4, y)
      ..lineTo(0, y / 4)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
