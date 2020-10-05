import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';
import '../../features/add_souvenir/view/pages/add_souvenir_page.dart';
import '../../features/list_souvenirs/view/pages/list_souvenirs_page.dart';
import '../../features/map/view/pages/map_page.dart';
import '../../features/profile/view/pages/profile_page.dart';
import '../../features/search/view/pages/search_page.dart';
import 'components/drawer.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  MotionTabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = MotionTabController(initialIndex: 0, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(     
          _tabController.index == 0 ? 'Home' : 
          _tabController.index == 1 ? "Search" :
          _tabController.index == 2 ? "Memories" : 
          _tabController.index == 3 ? "Map" : 
          "Profile"  
        ),

          centerTitle: true,
        ),
        drawer: MyDrawer(),
        bottomNavigationBar: MotionTabBar(
          labels: [
            "Home","Search","Memories","Map","Profile"
          ],
          initialSelectedTab: "Home",
          tabIconColor: Colors.white,
          tabSelectedColor: Colors.white,
          onTabItemSelected: (int value){
            print(value);
            setState(() {
              _tabController.index = value;
            });
          },
          icons: [
            Icons.home,Icons.search,Icons.add_box,Icons.public,Icons.account_box
          ],
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold
          ),
        ),
        body: MotionTabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
              child: ListSouvenirsPage()
            ),
            Container(
              child: SearchPage()
            ),
            Container(
              child: AddSouvenirsPage()
            ),
            Container(
              child: MapPage()
            ),
            Container(
              child: ProfilePage()
            ),
          ],
        ));
  }
}