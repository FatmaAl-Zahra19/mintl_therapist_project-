import 'package:flutter/material.dart';
import 'package:mintl555555555/features/user/Auth/presentation/pages/login/widgets/AuthService.dart';
import 'package:mintl555555555/features/user/Auth/presentation/pages/login/widgets/login_view_body.dart';
import 'package:mintl555555555/therapy/login/features/settings/conditions.dart';
import 'package:mintl555555555/therapy/login/features/settings/contactUsTherpist.dart';
import 'package:mintl555555555/therapy/login/therapylog.dart';
import 'package:mintl555555555/zzzz/wallet_page.dart';

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  bool isAvailable = true;
  final AuthService _authService = AuthService();

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
        automaticallyImplyLeading: false, // Remove back button
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Switch(
                    value: isAvailable,
                    onChanged: (value) {
                      setState(() {
                        isAvailable = value;
                      });
                    },
                    activeColor: Color(0xFFD68FFF),
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.grey.shade400,
                  ),
                  Text(
                    'متاح للعمل',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _menuOption(' محفظتي', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext) {
                          return WalletScreen();
                        },
                      ),
                    );
                  }),
                  _menuOption('تواصل معنا', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext) {
                          return const contactUsTherpist();
                        },
                      ),
                    );
                  }),
                  _menuOption('شروط الخدمه', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext) {
                          return const InsideCondition();
                        },
                      ),
                    );
                  }),
                  _menuOption('مركز المساعده', () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext) {
                    //       return  AddSessionButton();
                    //     },
                    //   ),
                    // );
                  }),
                  _menuOption('نسخه التطبيق', () {}),
                  _menuOption('تسجيل الخروج', () {
                    _authService.signOut(); // Call signOut method
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginViewBodythe(),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
