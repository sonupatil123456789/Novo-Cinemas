import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:zoom_widget/zoom_widget.dart';

import '../../../../core/constants/ImageConstants.dart';
import '../../domain/models/AreaModel.dart';
import '../../../../core/utils/ListnerUtils.dart';
import '../../domain/models/SeatLayoutModel.dart';
import '../../domain/models/SeatModel.dart';
import '../bloc/SeatLayoutBloc.dart';

class CinemaSeatLayout extends StatefulWidget {
  final SeatLayoutModel seatLayout;

  const CinemaSeatLayout({
    super.key,
    required this.seatLayout,
  });

  @override
  _CinemaSeatLayoutState createState() => _CinemaSeatLayoutState();
}

class _CinemaSeatLayoutState extends State<CinemaSeatLayout> {
  // final viewTransformationController = TransformationController();
  final double initialZoomFactor = 1;
  double iconSize = 4.5;
  final events = [];
  bool canScroll = true;
  final ScrollController _controller = ScrollController();
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();
  final Set<int> _activePointers = {};
  bool _canScroll = true;
  bool _showminiLayout = false;

  @override
  void initState() {

    _horizontalController.addListener(() {
      bool isScrolling;
      isScrolling = _horizontalController.position.isScrollingNotifier.value;
      if (isScrolling != _showminiLayout) {
        setState(() {
          _showminiLayout = isScrolling;
        });
      }
    });
    _verticalController.addListener(() {
      bool isScrolling;
      isScrolling = _verticalController.position.isScrollingNotifier.value;
      // print("isScrolling ---$isScrolling");
      if (isScrolling != _showminiLayout) {
        setState(() {
          _showminiLayout = isScrolling;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _horizontalController.removeListener(() {});
    _verticalController.removeListener(() {});
    super.dispose();
  }

  double _currentZoom = 1.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Listener(
          onPointerDown: (event) {
            // Disable scrolling when two fingers interact (for zoom/pan gestures).
            if (event.kind == PointerDeviceKind.touch) {
              setState(() => canScroll = false);
            }
          },
          onPointerUp: (event) {
            // Re-enable scrolling when all fingers are lifted.
            setState(() {
              canScroll = true;
              _showminiLayout = false;
            });
          },
          child: Zoom(
              backgroundColor: Colors.transparent,
              canvasColor: Colors.transparent,
              opacityScrollBars: 0,
              initScale: 1,
              maxScale: 2,
              onPositionUpdate: (position) {
                setState(() {
                  _currentZoom =
                      position.dx.abs() > 100 || position.dy.abs() > 100
                          ? 1.2
                          : 1.0;
                });
                print(_currentZoom);


              },

              // onPanUpPosition: ,
              onScaleUpdate: (scaleX, scaleY) {

                print('$scaleX =========== $scaleY');
                // if (_showminiLayout == false) {
                //   setState(() {
                //     _showminiLayout = true;
                //   });
                // }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: widget.seatLayout.areas != null
                    ? widget.seatLayout.areas!
                        .map((seatArea) => seatLayoutBuilder(seatArea))
                        .toList()
                    : [],
              )),
        ),
        // _showminiLayout ? miniSeatLayout() : const SizedBox.shrink(),
      ],
    );
  }

// Updated seatBuilder method
  Widget seatLayoutBuilder(AreaModel seatArea) {
    return Column(
      children: [
        seatAreaName(context, seatArea.name ?? ''),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: seatArea.rows != null
              ? seatArea.rows!.map((seatRow) {
                  if (seatRow.name == null || seatRow.name!.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return SizedBox(
                    height: context.getScreenWidth(6.5),
                    child: Row(
                      children: [
                        Container(
                          width: context.getScreenWidth(4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: context.colorPalette.transparentColor,
                          ),
                          child: Text(
                            seatRow.name ?? '',
                            style: context.textThemeDecoration.paragraphSmall
                                .copyWith(
                              fontWeight: FontWeight.w300,
                              color: context.colorPalette.textColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(width: context.getScreenWidth(3)),
                        ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: (seatRow.seats)?.length ?? 0,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final seatData = seatRow.seats?[index];
                              if (seatData!.isEmpty()) {
                                return Container(
                                    width: context.getScreenWidth(iconSize));
                              }
                              return BlocBuilder<SeatLayoutBloc,
                                  SeatLayoutState>(
                                buildWhen: (previous, current) =>
                                    previous.selectedSeat !=
                                    current.selectedSeat,
                                builder: (context, seatLayoutState) {
                                  return seat(
                                    seatData: seatData,
                                    seatState: seatLayoutState,
                                    onPress: (SeatModel seatData) {
                                      if (seatLayoutState.selectedSeat.length >9) {
                                        ListnersUtils.showErrorMessage('You have selected maximum no of seats',
                                            "Seat Error",context);
                                      }

                                      context.read<SeatLayoutBloc>().add(
                                            OnSeatSelected(
                                              seatData,
                                              seatArea.areaCategoryCode!,
                                              seatRow.name!,
                                              seatData.name!,
                                              seatArea.ticketTypeCode!,
                                              seatArea.priceInCents!,
                                              seatArea.name!,
                                            ),
                                          );
                                    },
                                  );
                                },
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  width: 7,
                                )),
                        // Row(
                        //   children: (seatRow.seats ?? []).map((seatData) {
                        //     if (seatData.isEmpty()) {
                        //       return Container(width: context.getScreenWidth(iconSize));
                        //     }
                        //     return BlocBuilder<SeatLayoutBloc, SeatLayoutState>(
                        //       buildWhen: (previous, current) =>
                        //           previous.selectedSeat != current.selectedSeat,
                        //       builder: (context, seatLayoutState) {
                        //         return seat(
                        //           seatData: seatData,
                        //           seatState: seatLayoutState,
                        //           onPress: (SeatModel seatData) {
                        //             context.read<SeatLayoutBloc>().add(
                        //                   OnSeatSelected(
                        //                     seatData,
                        //                     seatArea.areaCategoryCode!,
                        //                     seatRow.name!,
                        //                     seatData.name!,
                        //                     seatArea.ticketTypeCode!,
                        //                     seatArea.priceInCents!,
                        //                     seatArea.name!,
                        //                   ),
                        //                 );
                        //           },
                        //         );
                        //       },
                        //     );
                        //   }).toList(),
                        // ),
                      ],
                    ),
                  );
                }).toList()
              : <Widget>[],
        ),
      ],
    );
  }

  Widget seat(
      {required SeatModel seatData,
      required SeatLayoutState seatState,
      required Function onPress}) {
    return IgnorePointer(
      // ignoring: seatData.status == 0 || seatData.status == 3 ? false : true,
      ignoring: seatData.status == 0 ? false : true,
      child: GestureDetector(
        onTap: () {
          onPress(seatData);
        },
        child: Container(
          width: context.getScreenWidth(iconSize),
          alignment: Alignment.center,
          child: Stack(
            children: [
              SvgPicture.asset(
                  // colorFilter: ColorFilter.mode(context.colorPalette.accentColor, BlendMode.srcIn),
                  seatState.selectedSeat.contains(seatData)
                  ? ImageConstants.selectedSeat
                  : handelSeatIcon(seatData.status ?? 0)),

              if(seatData.status != 3)...[
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 3,
                    ),
                    child: Text(
                      seatData.name ?? '',
                      style: context.textThemeDecoration.subTitleLarge
                          .copyWith(fontSize: _currentZoom > 1.0 ? 6 : 0),
                    ),
                  ),
                ),
              ]

            ],
          ),
        ),
      ),
    );
  }

}

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}


Widget seatAreaName(BuildContext context, String name) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12, top: 12),
    child: RichText(
      text: TextSpan(
        style: context.textThemeDecoration.subTitleLarge, // Default text style
        children: <TextSpan>[
          TextSpan(
            text: 'NOVO ',
            style: context.textThemeDecoration.subTitleLarge.copyWith(
              color: context.colorPalette.accentColor,
            ),
          ),
          TextSpan(
            text: name,
          ),
        ],
      ),
    ),
  );
}

String handelSeatIcon(int status) {
  switch (status) {
    case == 0:
      return ImageConstants.avalableSeat; // can book seat
    case == 1:
      return ImageConstants.soldSeat; // sold
    case == 2:
      return ImageConstants.soldSeat; // house seat (already sold)
    case == 3:
      return ImageConstants.disableSeat; // special seat (premium seat)
    case == 4:
      return ImageConstants.soldSeat; // reserved seat
    case == 5:
      return ImageConstants.soldSeat; //  broken seat
    case == 6:
      return ImageConstants.soldSeat; // place holded (session holded seat)
    default:
      return ImageConstants.soldSeat;
  }
}

// class SeatDisplay extends StatefulWidget {
//   final SeatLayoutModel seatLayout;
//
//   const SeatDisplay({super.key, required this.seatLayout});
//
//   @override
//   State<SeatDisplay> createState() => _SeatDisplayState();
// }
//
// class _SeatDisplayState extends State<SeatDisplay> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Zoom(
//           backgroundColor: Colors.white,
//           canvasColor: Colors.deepOrange,
//           maxScale: 5,
//           initPosition: Offset(50, 80),
//           child: miniSeatLayout()),
//     );
//   }
//
//   Widget miniSeatLayout() {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       color: Colors.grey.withOpacity(0.5),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: widget.seatLayout.areas != null
//             ? widget.seatLayout.areas!
//                 .map((seatArea) => Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: seatArea.rows != null
//                           ? seatArea.rows!.map((seatRow) {
//                               if (seatRow.name == null ||
//                                   seatRow.name!.isEmpty) {
//                                 return const SizedBox.shrink();
//                               }
//                               return Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 2),
//                                 child: SizedBox(
//                                   height: 3,
//                                   // color: Colors.grey,
//                                   child: ListView.separated(
//                                       shrinkWrap: true,
//                                       scrollDirection: Axis.horizontal,
//                                       itemCount: (seatRow.seats)?.length ?? 0,
//                                       physics:
//                                           const NeverScrollableScrollPhysics(),
//                                       itemBuilder: (context, index) {
//                                         final seatData = seatRow.seats?[index];
//                                         if (seatData!.isEmpty()) {
//                                           return Container(width: 3);
//                                         }
//                                         return BlocBuilder<SeatLayoutBloc,
//                                             SeatLayoutState>(
//                                           buildWhen: (previous, current) =>
//                                               previous.selectedSeat !=
//                                               current.selectedSeat,
//                                           builder: (context, seatState) {
//                                             return Container(
//                                               width: 3,
//                                               alignment: Alignment.center,
//                                               color: miniSeatColor(seatState
//                                                       .selectedSeat
//                                                       .contains(seatData)
//                                                   ? 1
//                                                   : seatData.status == 0
//                                                       ? 0
//                                                       : 2),
//                                             );
//                                           },
//                                         );
//                                       },
//                                       separatorBuilder: (context, index) =>
//                                           const SizedBox(
//                                             width: 2,
//                                           )),
//                                 ),
//                               );
//                             }).toList()
//                           : <Widget>[],
//                     ))
//                 .toList()
//             : [],
//       ),
//     );
//   }
//
//   Color miniSeatColor(int item) {
//     Color iconColor;
//     switch (item) {
//       //available seats
//       case 0:
//         iconColor = context.colorPalette.accentColor;
//         break;
//       //selected seats
//       case 1:
//         iconColor = Colors.green;
//         break;
//       // sold seats
//       case 2:
//         iconColor = Colors.red;
//         break;
//       default:
//         iconColor = Colors.red;
//         break;
//     }
//     return iconColor;
//   }
// }
