import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class PageViewDemo extends StatefulWidget {
  const PageViewDemo({Key? key}) : super(key: key);

  @override
  State<PageViewDemo> createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo> {
  int bannerCount = 5;

  int _currentBanner = 0;

  @override
  Widget build(BuildContext context) {
    print('build called.....');
    return Scaffold(
      appBar: BrnAppBar(
        title: 'PageView',
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            child: PageView(
              onPageChanged: (index) => BrnToast.show('$index', context),
              controller: PageController(viewportFraction: 1.0),
              scrollDirection: Axis.horizontal,
              children: [
                _PageItem(color: Colors.red),
                _PageItem(color: Colors.green),
              ],
            ),
          ),
          Divider(),
          Text('PageView.builder构造器'),
          Container(
            height: 100,
            child: PageView.builder(
              onPageChanged: (index) => BrnToast.show(index.toString(), context),
              itemBuilder: (context, index) {
                if (index % 2 == 0) {
                  return _PageItem(color: Colors.pink);
                } else {
                  return _PageItem(color: Colors.brown);
                }
              },
              itemCount: 4,
            ),
          ),
          Text('PageView实现Banner效果'),
          Container(
            height: 80,
            child: Stack(
              children: [
                PageView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.red.withAlpha(10 * (index + 1)),
                      alignment: Alignment.center,
                      child: Text('$index'),
                    );
                  },
                  itemCount: bannerCount,
                  onPageChanged: (index) {
                    setState(() {
                      _currentBanner = index;
                    });
                  },
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          bannerCount,
                          (i) => Container(
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                height: 5,
                                width: 5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: i == _currentBanner ? Colors.blue : Colors.blue.withAlpha(50),
                                ),
                              )),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _PageItem extends StatelessWidget {
  const _PageItem({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
