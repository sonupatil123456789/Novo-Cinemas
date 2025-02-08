import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/PrivateBooking/presentation/screens/privatebooking_steps.dart';
import '../../../../components/CustomButton.dart';

class PrivateScreeningDetailDialogBox extends StatelessWidget {
  const PrivateScreeningDetailDialogBox({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          width: context.getScreenWidth(90),
          height: context.getScreenHeight(100),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
              color: context.colorPalette.backGroundColor,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "PRIVATE SCREENING",
                    overflow: TextOverflow.ellipsis,
                    style: context.textThemeDecoration.titleSmall,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        width: context.getScreenWidth(9),
                        height: context.getScreenWidth(9),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: context.colorPalette.accentColor,
                        ),
                        child: Icon(
                          Icons.close,
                          size: context.getScreenWidth(5),
                          color: context.colorPalette.backGroundColor,
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                discription,
                style: context.textThemeDecoration.paragraphMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 26,
              ),
              CustomButton(
                height: context.getScreenHeight(5),
                backgroundColor: context.colorPalette.accentColor,
                text: 'Book Now',
                textColor: context.colorPalette.blackColor,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PrivateBookingSteps();
                  }));
                },
                borderColor: Border.all(
                    color: context.colorPalette.accentColor, width: 2.0),
                width: context.getScreenWidth(100),
              ),
            ],
          )),
    );
  }
}

String discription =
    '''Experience the ultimate in cinematic luxury with Novo Cinemas' Private Screening with Movie package. Whether you're celebrating a special occasion, hosting a corporate event, or simply treating your friends and family to a unique movie night, our private screenings offer an unparalleled movie-watching experience that's exclusively yours.What We Offer:Exclusive Use of the Theatre: Enjoy the entire theater to yourself and your guests for the duration of the screening. No distractions, no interruptions – just you and your chosen movie on the big screen.Wide Selection of Movies: Choose from our extensive library of blockbuster hits, timeless classics, and latest releases to find the perfect movie for your private screening. Whether you're a fan of action, comedy, romance, or adventure, we have something for everyone.Customizable Experience: Tailor your private screening to suit your preferences with a range of customizable options. From selecting the movie and screening time to adding special touches like themed decorations, catering, and entertainment, our dedicated events team will work with you to create a truly unforgettable experience.VIP Treatment: Sit back, relax, and let us take care of all the details. From greeting your guests upon arrival to providing personalized service throughout the screening, our professional staff will ensure you and your guests feel like VIPs from start to finish.''';
