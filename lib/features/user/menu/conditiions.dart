import 'package:flutter/material.dart';
import 'package:mintl555555555/features/user/menu/menu_page.dart';

class conditions extends StatelessWidget {
  const conditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back button

        actions: [
          Text(
            '  شروط الخدمه',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Color(0xFF100D10),
              fontSize: 24,
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MenuPage()),
              );
            },
            child: Icon(Icons.arrow_forward_ios, size: 20),
          ),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: <Widget>[
          SizedBox(
            height: 32,
          ),
          Container(
            child: Text(
              'يتم حجز ثمن الجلسه لدي التطبيق لحين انتهاء الجلسه سوف يتم تحويل المبلغ للمعالج لضمان حقك',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF100D10),
                fontSize: 16,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            child: Text(
'في حاله الغاء الجلسه قبل باكثر من 24 ساعه لا يؤثر سلبا عليك ولا يتم خصم اي مبلغ منك ',              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF100D10),
                fontSize: 16,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            child: Text(
'في حاله الغاء الجلسه بعد 24 ساعه  سوف يتم انذارك او الخصم منك 20% من قيمه الجلسه لضمان الحفاظ علي  وقت المعالج',              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF100D10),
                fontSize: 16,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            child: Text(
'في حاله لم تدخل الجلسه سوف يتم تحذيرك 3 مرات و خضم منك نسبه 20% من ثمن الجلسه',              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF100D10),
                fontSize: 16,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            child: Text(
' اذا تكرر عدم دخولك للجلسات اكثر من 3 مرات سوف يتم منعك من حجز جلسات لفتره لضمان الحفاظ علي وقت المعالج',              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF100D10),
                fontSize: 16,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}




