import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class ConstraintDemo extends StatefulWidget {
  const ConstraintDemo({Key? key}) : super(key: key);

  @override
  State<ConstraintDemo> createState() => _ConstraintDemoState();
}

///https://flutter.cn/docs/development/ui/layout/constraints#example-2
///注意的地方：
/// 样例7
/// 样例8
///
///         ：样例9，ConstrainedBox仅对其从其父级接收到的约束下施加其他约束，忽略自己的constraints属性。
///           样例10，套一次center的话，Center 允许 ConstrainedBox 达到屏幕可允许的任意大小。 ConstrainedBox 将 constraints 参数带来的约束附加到其子对象上
///           样例11，Container 必须介于 70 到 150 像素之间。虽然它希望自己有 1000 个像素大小，但最终获得了 150 个像素（最大为 150）
///           样例12：UnconstrainedBox（UnconstrainedBox让他的子集决定大小，如果子集无限大double.infinity，将不会任何渲染） 允许其子级的 Container 可以变为任意大小，超出会越界警告
///           样例15（不明白）：OverflowBox 与 UnconstrainedBox 类似，但不同的是，如果其子级超出该空间，它将不会显示任何警告。
///           样例16：抛出异常
///           样例17：LimitedBox 和 UnconstrainedBox搭配？**仅其限制仅在获得无限约束时才适用！**
///
///           样例20：FittedBox（**理解成缩放组件**，在有限的区域内缩放） 会尝试根据 Text字体大小调整，Text一直是一行。如果去掉FiitedBox,Text换行，字体大小不变。
///           样例22：FittedBox 只能在**有限制的宽高**中对子 widget 进行缩放
///           样例25：比较常用
///           样例27：Flex主要是类似android的多个weight，子集怎么分配宽高。
///           样例28（真经）：当一个 widget 告诉其子级可以比自身更小的话，我们通常称这个 widget 对其子级使用 宽松约束（loose），loose理解成wrap_content
///           样例29：SizedBox.expand用法！！，当一个 widget 告诉它的子级必须变成某个大小的时候，我们通常称这个 widget 对其子级使用 严格约束（tight）确切大小，Match_parent Exactly
///                 SizedBox.expand 也可以用Container代替，但Container需要设置alignment才会填满父view
///
///           LayoutBuilder：根据父级的约束进行调整。https://api.flutter-io.cn/flutter/widgets/LayoutBuilder-class.html
///
class _ConstraintDemoState extends State<ConstraintDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          color: Colors.blue,
          child: Column(
            children: const [
              Text('Hello!'),
              Text('Goodbye!'),
            ],
          ),
        ),
      ),
    );
  }
}
