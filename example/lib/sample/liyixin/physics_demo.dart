import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

///
/// 滚动
///
class PhysicsDemo extends StatefulWidget {
  const PhysicsDemo({Key? key}) : super(key: key);

  @override
  State<PhysicsDemo> createState() => _PhysicsDemoState();
}

///
/// http://laomengit.com/flutter/widgets/ScrollPhysics.html#neverscrollablescrollphysics
/// physics: NeverScrollableScrollPhysics 禁止滚动
///
class _PhysicsDemoState extends State<PhysicsDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: 'Physics',
      ),
      body: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => Card(
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text('${index + 1}'),
              ),
            ),
            childCount: 50,
          ))
        ],
      ),
    );
  }
}

class MyCustomPhysics extends ScrollPhysics {
  @override
  ScrollPhysics? buildParent(ScrollPhysics? ancestor) {
    return super.buildParent(ancestor);
  }
}
