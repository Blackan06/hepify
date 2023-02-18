import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../screens/onboarding1.dart';
import '../utils/colors_util.dart';
import './setting_user.dart';
import 'edit_product_screen.dart';
import 'editthongtincanhan.dart';
import 'homepage.dart';
import 'homepagescreen.dart';
import 'listcustomerfav.dart';
import 'ordersrceen.dart';

class TabBarSrceen extends StatefulWidget {
  static const rountName = '/tabbar';
  @override
  State<TabBarSrceen> createState() => _TabBarSrceenState();
}

class _TabBarSrceenState extends State<TabBarSrceen> {
  @override
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': HomePageScreenHouse(),
        'title': 'Home',
      },
      {
        'page': OrdersScreen(),
        'title': 'History',
      },
      {
        'page': ListCustomerFav(),
        'title': 'Messing',
      },
      {
        'page': SettingUserSrceen(),
        'title': 'Settings',
      },
      // {
      //   'page':,
      //   'title': ,
      // },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.transparent,
        onTap: _selectPage,
        color: Color(0xFF4C53A5),
        height: 60,
        // type: BottomNavigationBarType.fixed,

        items: [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_bag_rounded,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.message_outlined,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.settings,
            size: 30,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
