import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../UI widgets/gradient-bg.dart';
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
    'notify': 'assets/icon/notify.svg',
    'threedot': 'assets/icon/threedot.svg',
  };

  Widget _buildBottomTabBar(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Theme.of(context).backgroundColor,
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
    final PreferredSize _appBar = PreferredSize(
      preferredSize: Size.fromHeight(65),
      child: AppBar(
        title: Container(
          margin: EdgeInsets.only(left: 15),
          child: Text(
            'Baby Care',
            style: TextStyle(
              fontFamily: 'Dosis',
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              _icons['notify'],
              color: Colors.white,
            ),
            iconSize: 30,
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset(
              _icons['threedot'],
              color: Colors.white,
            ),
            iconSize: 30,
            onPressed: () {},
          ),
        ],
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );

    return GradientBackground(
        screen[selectedIndex], context, _appBar, _buildBottomTabBar(context));
  }
}
