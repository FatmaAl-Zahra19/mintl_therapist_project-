import 'package:flutter/material.dart';
import 'package:mintl555555555/exp.dart';
import 'package:mintl555555555/features/Newsession/session/sessionuser.dart';
import 'package:mintl555555555/features/user/Auth/presentation/pages/login/nav.dart';
import 'package:mintl555555555/features/user/Auth/presentation/pages/login/widgets/AuthService.dart';
import 'package:mintl555555555/features/user/Auth/presentation/pages/login/widgets/login_view_body.dart';
import 'package:mintl555555555/features/user/Contact%20Us/ContactUs.dart';
import 'package:mintl555555555/features/user/menu/conditiions.dart';

import 'package:mintl555555555/try1.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final AuthService _authService = AuthService();
  bool light = true;

  Widget _menuOption(String title, VoidCallback onPressed) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            title,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal',
              color: Colors.black,
            ),
          ),
          onTap: onPressed,
        ),
        Divider(
          color: Color(0xFFD68FFF),
          thickness: 1,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(''),
        ),
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.only(right: 30),
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext) {
                    return NavigationPage();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: Scrollbar(
        child: Container(
          
          margin: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 16),
          child: ListView(
            children: [
        
              _menuOption('الملف الشخصي', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext) {
                      return Explor();
                    },
                  ),
                );
              }),
              _menuOption('الملف الشخصي لصديقك', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext) {
                      return  Explor();
                    },
                  ),
                );
              }),
              _menuOption('جلساتي', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext) {
                      return SessionUser();
                    },
                  ),
                );
              }),
              
              _menuOption('تواصل معنا', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext) {
                      return const ContactUs();
                    },
                  ),
                );
              }),
              _menuOption('مركز المساعده', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext) {
                      return  AddSessionButton(meetingId: '',);
                    },
                  ),
                );
              }),

              _menuOption('الخصوصيه و الحمايه', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext) {
                      return  Explor();
                    },
                  ),
                );
              }),
              _menuOption('شروط الخدمه', () {
                   Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext) {
                      return const conditions();
                    },
                  ),
                );
              }),

              
              _menuOption('نسخه التطبيق', () {

 
              }),
              _menuOption('تسجيل الخروج', () {
                _authService.signOut(); // Call signOut method
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginViewBody(),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
