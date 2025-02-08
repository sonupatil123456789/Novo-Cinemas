


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/components/CircularLoader.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/BookingHistory/presentation/bloc/BookingHistoryBloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/cards/BookingHistoryCard.dart';
import '../../../../components/dropdown/coustom_icon_dropdown.dart';


class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key});

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {

  final BorderRadius borderRadius = BorderRadius.circular(12);


  @override
  void initState() {
    context.read<BookingHistoryBloc>().add(const GetReservationHistoryDetailsEvent());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ArtBoard(
      header: BackButtonNavBar(onBackPress: () {Navigator.pop(context);},
        center: Container(
          height: double.infinity,
          // color: Colors.green,
          child: Row(
            children: [
              Text('Booking history', style: context.textThemeDecoration.titleSmall.copyWith(
                  fontWeight: FontWeight.bold
              ),),
              const Spacer(),

            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<BookingHistoryBloc, BookingHistoryState>(
          builder: (context, bookingHistoryState) {


            if(bookingHistoryState.loading == CurrentAppState.SUCCESS){

              if(bookingHistoryState.bookingHistory!.isNotEmpty){

                return ListView(
                  children: [

                    if(bookingHistoryState.resentBookingList.isNotEmpty)...[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: context.getScreenWidth(4),vertical: context.getScreenWidth(5)),
                        decoration: BoxDecoration(
                          borderRadius: borderRadius,
                          border: Border.all(width: 0.4, color: context.colorPalette.accentColor.withOpacity(0.6)),

                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Most Recent Booking',
                              style: context.textThemeDecoration.subTitleLarge,
                            ),

                            const SizedBox(height: 15,),

                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: bookingHistoryState.resentBookingList.length,
                              itemBuilder: (context, index) {
                                final resentData = bookingHistoryState.resentBookingList[index];
                                return  BookingHistoryCard(bookingHistory: resentData,);
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return const SizedBox(height: 15,);
                            },
                            ),
                          ],
                        ) ,
                      ),
                    ],



                    if(bookingHistoryState.pastBookingList.isNotEmpty)...[
                      const SizedBox(height: 15,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: context.getScreenWidth(4),vertical: context.getScreenWidth(5)),
                        decoration: BoxDecoration(
                          borderRadius: borderRadius,
                          border: Border.all(width: 0.4, color: context.colorPalette.accentColor.withOpacity(0.6)),

                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Past Booking',
                              style: context.textThemeDecoration.subTitleLarge,
                            ),

                            const SizedBox(height: 15,),

                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: bookingHistoryState.pastBookingList.length,
                              separatorBuilder: (BuildContext context, int index) {
                                return const SizedBox(height: 15,);
                              },
                              itemBuilder: (context, index) {
                                final pastData = bookingHistoryState.pastBookingList[index];
                                return  BookingHistoryCard(bookingHistory: pastData,);
                              },),
                          ],
                        ) ,
                      ),
                    ]
                  ],
                );


                return CustomScrollView(
                  slivers: [
                    MultiSliver(
                      pushPinnedChildren: true,
                      children: [
                        SliverPinnedHeader(
                          child: Container(
                            width: context.getScreenWidth(75),
                            height: context.getScreenHeight(5),
                            color: context.colorPalette.backGroundColor,
                            child: Text(
                              'Most Recent Booking',
                              style: context.textThemeDecoration.subTitleLarge,
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate((context, index) {
                            final resentData = bookingHistoryState.resentBookingList[index];
                            return BookingHistoryCard(bookingHistory: resentData);
                          },
                            childCount: bookingHistoryState.resentBookingList.length,
                          ),
                        ),
                      ],
                    ),



                    MultiSliver(
                      children: [
                        SliverPinnedHeader(
                          child: Container(
                            width: context.getScreenWidth(75),
                            height: context.getScreenHeight(5),
                            color: context.colorPalette.backGroundColor,
                            child: Text(
                              'Past Booking',
                              style: context.textThemeDecoration.subTitleLarge,
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate((context, index) {
                            final resentData = bookingHistoryState.pastBookingList[index];
                            return BookingHistoryCard(bookingHistory: resentData);
                          },
                            childCount: bookingHistoryState.pastBookingList.length,
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }

              return const Center(child: Text('No resent booking yet'),);

            }

            if(bookingHistoryState.loading == CurrentAppState.ERROR){
              return Center(child: Text(bookingHistoryState.appException?.message ?? ''),);

            }

            return const Center(child: CircularLoader(),);

          },
        ),
      ),
    );
  }
}





// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:novocinema/components/CircularLoader.dart';
// import 'package:novocinema/core/resources/enums.dart';
// import 'package:novocinema/core/theams/Utils.dart';
// import 'package:novocinema/src/BookingHistory/presentation/bloc/BookingHistoryBloc.dart';
// import 'package:sliver_tools/sliver_tools.dart';
// import '../../../../components/ArtBoard.dart';
// import '../../../../components/BackButtonNavbar.dart';
// import '../../../../components/HeaderTextOne.dart';
// import '../../../../components/cards/BookingHistoryCard.dart';
//
//
// class BookingHistoryScreen extends StatefulWidget {
//   const BookingHistoryScreen({super.key});
//
//   @override
//   State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
// }
//
// class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
//
//
//   @override
//   void initState() {
//     context.read<BookingHistoryBloc>().add(
//         const GetReservationHistoryDetailsEvent());
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return ArtBoard(
//       header: BackButtonNavBar(onBackPress: () {Navigator.pop(context);},
//         center: Container(
//           height: double.infinity,
//           // color: Colors.green,
//           child: Row(
//             children: [
//               Text('Movies', style: context.textThemeDecoration.titleSmall.copyWith(
//                   fontWeight: FontWeight.bold
//               ),),
//               const Spacer(),
//
//             ],
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//
//
//
//             Expanded(
//               child: BlocBuilder<BookingHistoryBloc, BookingHistoryState>(
//                 builder: (context, bookingHistoryState) {
//
//                   if(bookingHistoryState.loading == CurrentAppState.SUCCESS){
//
//                     if(bookingHistoryState.bookingHistory!.isNotEmpty){
//
//                       return CustomScrollView(
//                         slivers: [
//                           MultiSliver(
//                             pushPinnedChildren: true,
//                             children: [
//                               SliverPinnedHeader(
//                                 child: Container(
//                                   width: context.getScreenWidth(75),
//                                   height: context.getScreenHeight(5),
//                                   color: context.colorPalette.backGroundColor,
//                                   child: Text(
//                                     'Most Recent Booking',
//                                     style: context.textThemeDecoration.subTitleLarge,
//                                   ),
//                                 ),
//                               ),
//                               SliverList(
//                                 delegate: SliverChildBuilderDelegate((context, index) {
//                                     final resentData = bookingHistoryState.resentBookingList[index];
//                                     return BookingHistoryCard(bookingHistory: resentData);
//                                   },
//                                   childCount: bookingHistoryState.resentBookingList.length,
//                                 ),
//                               ),
//                             ],
//                           ),
//
//
//
//                           MultiSliver(
//                             children: [
//                               SliverPinnedHeader(
//                                 child: Container(
//                                   width: context.getScreenWidth(75),
//                                   height: context.getScreenHeight(5),
//                                   color: context.colorPalette.backGroundColor,
//                                   child: Text(
//                                     'Past Booking',
//                                     style: context.textThemeDecoration.subTitleLarge,
//                                   ),
//                                 ),
//                               ),
//                               SliverList(
//                                 delegate: SliverChildBuilderDelegate((context, index) {
//                                   final resentData = bookingHistoryState.pastBookingList[index];
//                                   return BookingHistoryCard(bookingHistory: resentData);
//                                 },
//                                   childCount: bookingHistoryState.pastBookingList.length,
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       );
//                     }
//
//                     return const Center(child: Text('No resent booking yet'),);
//
//                   }
//
//                   if(bookingHistoryState.loading == CurrentAppState.ERROR){
//                     return Center(child: Text(bookingHistoryState.appException?.message ?? ''),);
//
//                   }
//
//                   return const Center(child: CircularLoader(),);
//
//                 },
//               ),
//             )
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
