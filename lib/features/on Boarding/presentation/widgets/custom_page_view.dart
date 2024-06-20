import 'package:flutter/material.dart';
import 'package:mintl555555555/features/on%20Boarding/presentation/widgets/page_view_item.dart';

import '../../../../core/utils/size_config.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({Key? key,@required this.pageController}) : super(key: key);
  final PageController? pageController;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/onbording_bak.png'), // replace with your background image
          fit: BoxFit.cover,
        ),
      ),
      child: PageView(
        controller: pageController,
        children: [
          
          
           
            Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
              child: PageViewItem(
                image: 'assets/images/illustration for onbording1.png',
                title: '',
                subTitle: 'يُعد تطبيق "Mint-L" شريكًا موثوقًا وداعمًا للمستخدمين في رحلتهم الشخصية والعاطفية. يجمع بين القدرات الفريدة لتتبع المزاج والمعالج النفسي الافتراضي لتقديم تجربة معززة ومرضية، وذلك لتحسين العافية العامة والسعادة النفسية للمستخدمين.',
              ),
            ),
          
          
             Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
               child: PageViewItem(
                image: 'assets/images/illustration for onbording2.png',
                title: '',
                subTitle: 'تطبيق "Mint-L" هو منصة مبتكرة واداة قوية وملائمة تتيح للأطباء النفسيين الانضمام وتقديم خدماتهم عبر الإنترنت.حيث يمكنهم العمل بمرونة والوصول إلى جمهور واسع من المرضى في أي وقت ومن أي مكان. ',
                           ),
             ),
        
        ],
      ),
    );
  }
}