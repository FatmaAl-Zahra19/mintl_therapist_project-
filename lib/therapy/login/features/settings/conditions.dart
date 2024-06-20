import 'package:flutter/material.dart';
import 'package:mintl555555555/therapy/login/features/settings/nav2.dart';
import 'package:mintl555555555/therapy/login/features/settings/settings.dart';


class InsideCondition extends StatelessWidget {
  const InsideCondition({Key? key}) : super(key: key);

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
                MaterialPageRoute(builder: (context) => NavigationPagethr2()),
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
              '    1- نسبة العمولة :',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF100D10),
                fontSize: 16,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            child: Text(
          
          'يأخذ تطبيق "الدكتور" نسبة 20% من قيمة كل جلسة يجريها المستخدم من خلال التطبيق. وبذلك تحصل على 80% من قيمة الجلسة.',  textAlign: TextAlign.right,
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
              "2- خصمات الجلسات   :",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF100D10),
                fontSize: 16,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            child: Text(
"اول جلسة مع كل مستخدم جديد تكون عليها خلص. وفي مقابل ذلك، لن يأخذ التطبيق منك نسبة العمولة البالغة 10% عن هذه الجلسة.",              textAlign: TextAlign.right,
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
              "3- حجز ثمن الجلسة :",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF100D10),
                fontSize: 16,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            child: Text(

"يتم حجز ثمن الجلسة في حساب التطبيق حتى انتهاء الجلسة. وبعد انتهاء الجلسة، يتم تحويل المبلغ إلى محفظتك الشخصية، والتي يمكنك سحب المبلغ منها في أي وقت.",            textAlign: TextAlign.right,
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
              "4- إلغاء الجلسة :",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF100D10),
                fontSize: 16,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            child: Text(
'في حال إلغاء الجلسة بعد 24 ساعة من تحديد موعدها، فسوف يتم إنذارك أو خصم مبلغ من محفظتك.',  
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
              "5- عدم دخول الجلسة :",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF100D10),
                fontSize: 16,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),

          Container(
            child: Text(
"في حال عدم دخولك إلى الجلسة في الموعد المحدد، فسوف يتم تحذيرك. وإذا تكرر ذلك، فسوف يتم حذفك من التطبيق. وذلك لضمان سلامة عملائنا وسمعتنا ",              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF100D10),
                fontSize: 16,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
     Container(
            child: Text(
"في حال عدم دخول المستخدم إلى الجلسة، وفي حال أن الجلسة غير مجانية، فسوف يتم خصم نسبة 20% من ثمن الجلسة من المستخدم، وسوف يتم تحويل المبلغ المتبقي إلى محفظتك الشخصية بنسبة 80%. دي في رقم 6",              textAlign: TextAlign.right,
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
            '6-لالتزام بأخلاقيات المهنة الطبية :',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF100D10),
                fontSize: 16,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),

 Container(
            child: Text(
'يلتزم جميع المستخدمين بأخلاقيات المهنة الطبية، بما في ذلك:',
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

          Container(
            child: Text(
' الحفاظ على سرية معلومات المريض.'
,
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
      Container(
            child: Text(
              'عدم تقديم معلومات طبية غير صحيحة أو مضللة.'
,
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


Container(
            child: Text(
             'عدم استغلال المريض أو ابتزازه.'
,
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
           '7-عدم الكشف عن أسرار المريض :'
            ,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF100D10),
                fontSize: 16,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),

 Container(
            child: Text('يلتزم جميع المستخدمين بعدم الكشف عن أسرار المريض، بما في ذلك:'
,
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

Container(
            child:
             Text(
' المعلومات الشخصية للمريض.',
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
Container(
            child: Text(
              'المعلومات الطبية للمريض.'
,
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
            child: Text('8-عدم استخدام التطبيق لأغراض غير قانونية :'
            ,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF100D10),
                fontSize: 16,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),

 Container(
            child: Text(' تقديم خدمات طبية غير مصرح بها.'
,
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
 Container(
            child: Text(
' نشر معلومات طبية مضللة أو غير صحيحة.',
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
           Container(
            child: Text(
' استغلال المريض أو ابتزازه.',
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
        




        ],
      ),
    );
  }
}




