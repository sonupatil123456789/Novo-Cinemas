import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/core/constants/RoutesName.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/DirectFnB/presentation/bloc/DirectF&BBloc.dart';
import 'package:novocinema/src/OrderConfirmation/presentation/bloc/OrderConfirmationBloc.dart';
import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/CustomButton.dart';
import '../../../../core/constants/ImageConstants.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/utils/ListnerUtils.dart';
import '../../../../di.dart';
import '../../../F&B/presentation/bloc/F&BBloc.dart';
import '../../../../components/CustomTextField.dart';
import '../../../F&B/presentation/screens/FAndBScreen.dart';
import '../components/MovieDetailsCard.dart';

class DirectFnBOrderConfirmationScreen extends StatefulWidget {
  final String reservationId;
  final FAndBType fAndBType;

  const DirectFnBOrderConfirmationScreen(
      {super.key, required this.reservationId, required this.fAndBType});

  @override
  State<DirectFnBOrderConfirmationScreen> createState() =>
      _DirectFnBOrderConfirmationScreenState();
}

class _DirectFnBOrderConfirmationScreenState
    extends State<DirectFnBOrderConfirmationScreen> {
  final BorderRadius borderRadius = BorderRadius.circular(12);
  late DirectFAndBBloc directFAndBBloc;
  late FAndBBloc fAndBBloc;

  @override
  void initState() {
    directFAndBBloc = getIt<DirectFAndBBloc>();
    fAndBBloc = getIt<FAndBBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ArtBoard(
      header: BackButtonNavBar(onBackPress: () {
        context.read<OrderConfirmationBloc>().add(CancelFAndBEvent(
            reservationId: widget.reservationId,
            onSuccess: () {
              Navigator.pop(context);
            }));
      }),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          context.read<OrderConfirmationBloc>().add(CancelFAndBEvent(
              reservationId: widget.reservationId,
              onSuccess: () {
                Navigator.pop(context);
              }));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(widget.reservationId),
                if (widget.fAndBType == FAndBType.DIRECT_FANDB) ...[
                  MovieDetailsCard(
                    directFAndBBloc: directFAndBBloc,
                    fAndBBloc: fAndBBloc,
                  ),
                ],
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
      footer: BlocBuilder<OrderConfirmationBloc, OrderConfirmationState>(
        builder: (context, orderState) {
          var isLoading =
          orderState.confirmationOrderState == CurrentAppState.LOADING
              ? true
              : false;

          return Container(
            width: context.getScreenWidth(100),
            height: context.getScreenHeight(8),
            color: context.colorPalette.backGroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // CustomButton(
                //   height: context.getScreenHeight(6),
                //   backgroundColor: context.colorPalette.transparentColor,
                //   text: 'Skip',
                //   textColor: context.colorPalette.accentColor,
                //   onTap: () {},
                //   borderColor: Border.all(
                //       color: context.colorPalette.accentColor,
                //       width: 2.0
                //   ),
                //   width: context.getScreenWidth(40),
                // ),

                CustomButton(
                  height: context.getScreenHeight(6),
                  backgroundColor: context.colorPalette.accentColor,
                  text: isLoading ? 'Loading...' : 'Continue',
                  textColor: context.colorPalette.darkGreyColor,
                  onTap: () {
                    context
                        .read<OrderConfirmationBloc>()
                        .add(CompleteOrderEvent(
                        reservationId: widget.reservationId,
                        onFailure: (AppException error) {
                          ListnersUtils.showErrorMessage(
                              error.message, 'Reservation Error', context);
                        },
                        onSuccess: () {
                          Navigator.pushNamed(context, RoutesName.ticketListScreen, arguments: {
                            'reservationId': widget.reservationId,
                            'isDeepLinking': false
                          });
                        }));
                  },
                  width: context.getScreenWidth(90),
                  isDisabled: isLoading,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


// creat a coustom countdown timer class wher i can pass the timing from parameter in flutter dart using stream and it shoul retain the same timer from previous screen
