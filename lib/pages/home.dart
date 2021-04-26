import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'baby-detail/baby-detail.dart';
import 'catalog.dart';
import 'user-management/user.dart';
import 'vaccine/vaccine.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final screen = [
    CatalogPage(),
    BabyDetailPage(),
    VaccinePage(),
    UserPage(),
  ];
  final Map<String, String> _icons = {
    'home': 'assets/icon/home.svg',
    'baby-health': 'assets/icon/carriage.svg',
    'vaccine': 'assets/icon/vaccine.svg',
    'user': 'assets/icon/user_circle.svg',
  };

  Widget _buildBottomTabBar(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Theme.of(context).backgroundColor,
      buttonBackgroundColor: Colors.white,
      items: [
        Tab(
          icon: SvgPicture.asset(
            _icons['home'],
            color: Color.fromRGBO(0, 0, 0, .5),
          ),
        ),
        Tab(
          icon: SvgPicture.asset(
            _icons['baby-health'],
            color: Color.fromRGBO(0, 0, 0, .5),
          ),
        ),
        Tab(
          icon: SvgPicture.asset(
            _icons['vaccine'],
            color: Color.fromRGBO(0, 0, 0, .5),
          ),
        ),
        Tab(
          icon: SvgPicture.asset(
            _icons['user'],
            color: Color.fromRGBO(0, 0, 0, .5),
          ),
        ),
      ],
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Product',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      bottomNavigationBar: _buildBottomTabBar(context),
      body: screen[selectedIndex],
    );
  }
}
