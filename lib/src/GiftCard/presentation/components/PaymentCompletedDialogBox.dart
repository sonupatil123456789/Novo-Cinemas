import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/core/theams/Utils.dart';
import '../../../../components/CustomButton.dart';


const String icon = '''
<svg width="152" height="121" viewBox="0 0 152 121" fill="none" xmlns="http://www.w3.org/2000/svg">
<circle cx="50" cy="70.5" r="50" fill="#FFEF00" fill-opacity="0.3"/>
<path d="M104.5 31H54.5C51.7386 31 49.5 33.2386 49.5 36V86C49.5 88.7614 51.7386 91 54.5 91H104.5C107.261 91 109.5 88.7614 109.5 86V36C109.5 33.2386 107.261 31 104.5 31Z" stroke="#FFEF00" stroke-width="6.66667" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M49.5 44.332H106.167" stroke="#FFEF00" stroke-width="6.66667" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M89.5 57.668H109.5" stroke="#FFEF00" stroke-width="6.66667" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M89.5 71H109.5" stroke="#FFEF00" stroke-width="6.66667" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M77.832 57.668H79.4987" stroke="#FFEF00" stroke-width="6.66667" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M77.832 71H79.4987" stroke="#FFEF00" stroke-width="6.66667" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M62.832 31V91" stroke="#FFEF00" stroke-width="6.66667" stroke-linecap="round" stroke-linejoin="round"/>
<rect x="110" y="15.5" width="42" height="42" rx="21" fill="#FFEF00"/>
<path d="M123.5 36.5L128.5 41.5L138.5 31.5" stroke="black" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
''';


class PaymentCompletedDialogBox extends StatelessWidget {
  const PaymentCompletedDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: context.getScreenWidth(80),
        height: context.getScreenHeight(35),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: context.colorPalette.backGroundColor,
            borderRadius: BorderRadius.circular(20)),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


            const SizedBox(
              height: 10,
            ),

            SvgPicture.string(icon),

            const SizedBox(
              height: 20,
            ),
            Text(
              "Payment Done successfully!",
              overflow: TextOverflow.ellipsis,
              style: context.textThemeDecoration.titleSmall,
            ),
            const SizedBox(
              height: 5,
            ),

            Text(
              "You will receive your gift cards on user@gmail.com. In case of any query please contact support@novocinemas.com",
              style: context.textThemeDecoration.paragraphMedium,
              textAlign: TextAlign.center,
            ),


            const SizedBox(
              height: 26,
            ),

            CustomButton(
              height: context.getScreenHeight(5),
              backgroundColor: context.colorPalette.transparentColor,
              text: 'Back to main page',
              textColor: context.colorPalette.accentColor,
              onTap: () async {

              },
              borderColor: Border.all(
                  color: context.colorPalette.accentColor, width: 2.0),
              width: context.getScreenWidth(100),
            ),

          ],
        )
      ),
    );
  }
}
