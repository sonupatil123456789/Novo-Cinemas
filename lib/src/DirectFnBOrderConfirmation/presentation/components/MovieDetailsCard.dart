import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/DirectFnB/presentation/bloc/DirectF&BBloc.dart';
import '../../../../core/constants/ImageConstants.dart';
import '../../../../core/theams/TextTheamStyle.dart';
import '../../../../core/utils/CurrencyFormater.dart';
import '../../../../core/utils/DateFormater.dart';
import '../../../F&B/presentation/bloc/F&BBloc.dart';


class MovieDetailsCard extends StatefulWidget {

   DirectFAndBBloc? directFAndBBloc ;
    FAndBBloc? fAndBBloc;
   MovieDetailsCard({super.key,
     this.directFAndBBloc,
     this.fAndBBloc
   });



  @override
  State<MovieDetailsCard> createState() => _MovieDetailsCardState();
}

class _MovieDetailsCardState extends State<MovieDetailsCard> {


  // late final SessionTimer _countdownTimer ;



  // @override
  // void initState() {
  //   _countdownTimer = SessionTimer();
  //   super.initState();
  // }



  @override
  Widget build(BuildContext context) {

    final directFAndBState = widget.directFAndBBloc?.state;
    final fAndBState = widget.fAndBBloc?.state;
    final details = directFAndBState?.selectedReservationDetail;




    return Container(
      width: context.getScreenWidth(90),
      padding: EdgeInsets.all(context.getScreenWidth(4)),
      decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: context.colorPalette.reverseBackGroundColor.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [




          const SizedBox(height: 15,),


            movieDetailsCard(movieImage: details?.movie?.movieImageUrl,
              movieDate: details?.showDate,
              movieName: details?.movie?.movieTitle,
              movieTime: details?.showTime,
              movieMallName: details?.cinema?.name,),



          if(directFAndBState != null)...[
            const SizedBox(height: 15,),
            Text(
              'Seats',
              style: context.textThemeDecoration.subTitleMedium.copyWith(fontFamily: TextThemeDecoration.HamburgerFont),
            ),
            Divider(
              color: context.colorPalette.reverseBackGroundColor,
              thickness: 0.2,
            ),
            Column(
                children:(details?.seatName)!.map((entries){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                          TextSpan( children: [
                            TextSpan(text: "NOVO",style: context.textThemeDecoration.subTitleSmall.copyWith(color: context.colorPalette.accentColor,fontSize: 14)),
                            const TextSpan(text: " "),
                            TextSpan(text: entries.areaName,style: context.textThemeDecoration.subTitleSmall.copyWith(fontSize: 14),)
                          ])
                      ),
                      const SizedBox(height: 2,),
                      Text(
                        entries.seats?.replaceAll('-', "").replaceAll(',', ', ') ?? '',
                        style: context.textThemeDecoration.subTitleSmall.copyWith(fontFamily: TextThemeDecoration.HamburgerFont),
                      ),
                      const SizedBox(height: 4,),
                    ],
                  );
                }).toList()
            )
          ],


          if(fAndBState!= null && fAndBState.addConcessionItemList.isNotEmpty)...[
            const SizedBox(height: 15,),
            Text(
              'Food & Beverage',
              style: context.textThemeDecoration.subTitleMedium.copyWith(fontFamily: TextThemeDecoration.HamburgerFont),
            ),
            Divider(
              color: context.colorPalette.reverseBackGroundColor,
              thickness: 0.2,
            ),
            Column(
                children: fAndBState.addConcessionItemList.map((fAndBItem){
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            (fAndBItem['Name'] as String?) ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textThemeDecoration.subTitleSmall.copyWith(fontSize: 14),
                          ),
                        ),
                        SizedBox(width: context.getScreenWidth(10),),
                        Text(
                          '${(fAndBItem['Quantity'].toString())} X QAR ${priceConverter(((fAndBItem['Price'] as num?) ?? 0)).toString()}',
                          style: context.textThemeDecoration.subTitleSmall.copyWith(fontSize: 14),
                        )
                      ],
                    ),
                  );
                }).toList()
            )
          ]
        ],
      ),
    );
  }






  Widget movieDetailsCard({
  required String? movieImage,
  required String? movieDate,
  required String? movieName,
  required String? movieTime,
  required String? movieMallName
  }){


    return  SizedBox(
      height: context.getScreenHeight(7),
      child: Row(
        children: [
          ClipRRect(
            borderRadius:BorderRadius.circular(12),
            child: SizedBox(
              width: context.getScreenWidth(20),
              child : CachedNetworkImage(
                imageUrl: movieImage ?? '',
                height: context.getScreenHeight(7),
                width: context.getScreenWidth(26),
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Image.asset(
                  ImageConstants.fallBackImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movieName?? '',
                style: context.textThemeDecoration.subTitleSmall.copyWith(fontFamily: TextThemeDecoration.HamburgerFont),),
              Text(movieMallName ?? '', style: context.textThemeDecoration.paragraphLarge),
              const SizedBox(height: 1,),
              Text("${movieDate?.split(',')[1].trim()}  |  ${movieTime ?? ''}", style: context.textThemeDecoration.paragraphLarge.copyWith(
                  color: context.colorPalette.accentColor
              )),
            ],
          )
        ],
      ),
    );

  }












}

