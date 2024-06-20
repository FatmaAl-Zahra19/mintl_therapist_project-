import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mintl555555555/exp.dart';
import 'package:mintl555555555/features/meet/join_screen.dart';
import 'package:mintl555555555/features/user/Auth/presentation/pages/login/homepage.dart';

import 'package:mintl555555555/features/user/ther/therlist.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 4;

  static List<Widget> _widgetOptions = <Widget>[
  //  JoinScreen(),
  TherapistCardPage(),
    Explor(),
    // SummarizePage(),
    Explor(),
    Explor(),
    HomePage(),
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
              'assets/images/users.svg',
              width: 24.0,
              height: 24.0,
              color:
                  _selectedIndex == 0 ? Color(0xFFD68FFF) : Color(0xFFE8E0E5),
            ),
            label: 'المعالج',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/exp.svg',
              width: 24.0,
              height: 24.0,
              color:
                  _selectedIndex == 1 ? Color(0xFFD68FFF) : Color(0xFFE8E0E5),
            ),
            label: 'تعلم',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/shape.svg',
              width: 24.0,
              height: 24.0,
              color:
                  _selectedIndex == 2 ? Color(0xFFD68FFF) : Color(0xFFE8E0E5),
            ),
            label: 'رسالة لك',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/edit-4.svg',
              width: 24.0,
              height: 24.0,
              color:
                  _selectedIndex == 3 ? Color(0xFFD68FFF) : Color(0xFFE8E0E5),
            ),
            label: 'ملاحظاتي',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Home.svg',
              width: 24.0,
              height: 24.0,
              color:
                  _selectedIndex == 4 ? Color(0xFFD68FFF) : Color(0xFFE8E0E5),
            ),
            label: 'الرئيسية',
          ),
        ],
      ),
    );
  }
}

class TherapyBody extends StatelessWidget {
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

class MassgeForyou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'MassgeForyou',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// class Explor extends StatelessWidget {
//     TextEditingController _textEditingController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Post'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _textEditingController,
//               decoration: InputDecoration(
//                 labelText: 'Enter your post',
//               ),
//               maxLines: null,
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 String postContent = _textEditingController.text;
//                 // Save post to backend database
//                 // Replace this with your actual implementation
//                 print('Post content: $postContent');
//                 // After saving the post, you might navigate back to the previous screen
//                 Navigator.pop(context);
//               },
//               child: Text('Post'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
