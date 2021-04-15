import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:memolidays/features/map/view/pages/map_page.dart';
import 'package:memolidays/features/souvenirs/view/pages/add_souvenir_page.dart';
import 'package:memolidays/features/souvenirs/view/pages/list_souvenirs_page.dart';
// import 'package:motion_tab_bar/MotionTabBarView.dart';
// import 'package:motion_tab_bar/MotionTabController.dart';
// import 'package:motion_tab_bar/motiontabbar.dart';
import 'components/drawer.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController _tabController;
  // MotionTabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length:3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void changeTab(int index) {
    _tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
          _tabController.index == 0 ? 'Home' :
          _tabController.index == 1 ? "Memories" :
          "Map"
        ),
          centerTitle: true,
        ),
        drawer: MyDrawer(),
        bottomNavigationBar: ConvexAppBar(
          controller: _tabController,
          items: [
            TabItem(
              icon: Icons.home
            ),
            TabItem(
              icon: Icons.add_box
            ),
            TabItem(
              icon: Icons.public
            ),
          ],
          initialActiveIndex: 0,
          backgroundColor: Colors.orange,
          color: Colors.white,
          activeColor: Colors.white,
          style: TabStyle.react,
          // tabIconColor: Colors.white,
          // tabSelectedColor: Colors.white,
          // onTabItemSelected: (int value){
          //   setState(() {
          //     _tabController.index = value;
          //   });
          // },
          // textStyle: TextStyle(
          //   color: Colors.white,
          //   fontSize: 12,
          //   fontWeight: FontWeight.bold
          // ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
              child: ListSouvenirsPage(changeTab)
            ),
            Container(
              child: AddSouvenirsPage(changeTab)
            ),
            Container(
              // child: MapPage()
              child: MapPage(),
            ),
          ],
        ));
  }
}