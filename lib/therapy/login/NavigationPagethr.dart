import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mintl555555555/features/meet/join_screen.dart';
import 'package:mintl555555555/features/user/Auth/presentation/pages/login/homepage.dart';
import 'package:mintl555555555/ssss.dart';
import 'package:mintl555555555/therapy/login/features/sessionlist/therapistsession.dart';
import 'package:mintl555555555/therapy/login/features/settings/settings.dart';
import 'package:mintl555555555/zzzz/display_info_for_therapy.dart';

class NavigationPagethr extends StatefulWidget {
  @override
  _NavigationPagethrState createState() => _NavigationPagethrState();
}

class _NavigationPagethrState extends State<NavigationPagethr> {
  int _selectedIndex = 3;

  static final List<Widget> _widgetOptions = <Widget>[
     settings(),
     notifications(),
    SessionTherapist(),
    TherapistsListPage111(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF1D1B1E),
        selectedItemColor: Color(0xFFD68FFF),
        unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/settings.svg',
              width: 24.0,
              height: 24.0,
              color:
                  _selectedIndex == 0 ? Color(0xFFD68FFF) : Color(0xFFE8E0E5),
            ),
            label: 'الاعدادات',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/bell2.svg',
              width: 24.0,
              height: 24.0,
              color:
                  _selectedIndex == 1 ? Color(0xFFD68FFF) : Color(0xFFE8E0E5),
            ),
            label: 'الاشعارات',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/calendar.svg',
              width: 24.0,
              height: 24.0,
              color:
                  _selectedIndex == 2 ? Color(0xFFD68FFF) : Color(0xFFE8E0E5),
            ),
            label: ' الجلسات',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/user-1.svg',
              width: 24.0,
              height: 24.0,
              color:
                  _selectedIndex == 3 ? Color(0xFFD68FFF) : Color(0xFFE8E0E5),
            ),
            label: 'الملف الشخصي',
          ),
        ],
      ),
    );
  }
}

class therapistProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'therapypage',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'notifications',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
