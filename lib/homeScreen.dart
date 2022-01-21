import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> _list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, val) => [
            SliverAppBar(
              centerTitle: true,
              leading: FlutterLogo(),
              title: Text("Flutter ScrollNotification"),
            ),
            SliverPersistentHeader(
              delegate: Delegate(),
              pinned: true,
            )
          ],
          body: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification) {
                if (notification.metrics.pixels ==
                    notification.metrics.maxScrollExtent) {
                  final tempList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
                  setState(() => _list.addAll(tempList));
                  return true;
                }
              }
              return true;
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: List.generate(
                  _list.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Material(
                      elevation: 4,
                      child: ListTile(
                        title: Text(index.toString()),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 100;
  @override
  double get maxExtent => 250;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.purpleAccent[400],
      child: FlutterLogo(
        size: 250,
      ),
    );
  }

  @override
  bool shouldRebuild(Delegate oldDelegate) {
    return false;
  }
}
