import 'package:flutter/material.dart';
import 'package:novocinema/components/CustomInAppWebView.dart';
import 'package:novocinema/src/AncillaryPages/presentation/screens/ExperienceDetailsScreen.dart';
import 'package:novocinema/src/Auth/presentation/screens/ForgotPasswordScreen.dart';
import 'package:novocinema/src/BookingHistory/presentation/screens/BookingHistoryScreen.dart';
import 'package:novocinema/src/DirectFnB/presentation/screens/DirectFnbSelectionScreen.dart';
import 'package:novocinema/src/DirectFnB/presentation/screens/DirectFnbSummaryScreen.dart';
import 'package:novocinema/src/DirectFnB/presentation/screens/TakeAwayFnbBookingScreen.dart';
import 'package:novocinema/src/F&B/presentation/screens/FAndBScreen.dart';
import 'package:novocinema/src/GiftCard/presentation/screens/TopUpGiftCard.dart';
import 'package:novocinema/src/Offers/presentation/screens/OffersScreen.dart';
import 'package:novocinema/src/Search/presentation/screens/SearchScreen.dart';
import 'package:novocinema/src/SeatLayout/presentation/screens/SeatLayoutScreen.dart';
import 'package:novocinema/src/Settings/screens/setting_screen.dart';
import '../../src/Auth/presentation/screens/OtpVerificationScreen.dart';
import '../../src/Auth/presentation/screens/ResetPasswordScreen.dart';
import '../../src/Dashboard/presentation/screens/DashboardScreen.dart';
import '../../src/DirectFnBOrderConfirmation/presentation/screens/DirectFnBOrderConfirmationScreen.dart';
import '../../src/GiftCard/presentation/screens/AddGiftCardBalance.dart';
import '../../src/GiftCard/presentation/screens/GiftCardOrderSummery.dart';
import '../../src/GiftCard/presentation/screens/SendGiftCardScreen.dart';
import '../../src/GiftCard/presentation/screens/CheckGiftCardsBalanceScreen.dart';
import '../../src/GiftCard/presentation/screens/GiftCardScreen.dart';
import '../../src/Location/presentation/screens/location_screen.dart';
import '../../src/MainSection.dart';
import '../../src/MovieDetails/presentation/screens/MovieDetailScreen.dart';
import '../../src/Movies/presentation/screens/MoviesScreen.dart';
import '../../src/OrderConfirmation/presentation/screens/OrderConfirmationScreen.dart';
import '../../src/ShowTime/presentation/screens/ShowTimeScreen.dart';
import '../../src/SideNavBar/presentation/screens/SideBarScreen.dart';
import '../../src/Tickets/presentation/screens/TicketListScreen.dart';
import '../../src/UserProfile/presentation/screens/UserProfileDetailsScreen.dart';
import '../../src/UserProfile/presentation/screens/UserProfileScreen.dart';
import '../constants/RoutesName.dart';

class Routes {
  static MaterialPageRoute generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.mainSection:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutesName.mainSection),
          builder: (BuildContext context) => const MainSection(),
        );

      case RoutesName.sideBar:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutesName.sideBar),
          builder: (BuildContext context) => SideBarScreen(),
        );

      // case RoutesName.loginScreen:
      //   return MaterialPageRoute(
      //     settings: const RouteSettings(name: RoutesName.loginScreen),
      //     builder: (BuildContext context) =>  LogInScreen(onLogin: (bool ) {  },),
      //   );

      // case RoutesName.signeUpScreen:
      //   return MaterialPageRoute(
      //     settings: const RouteSettings(name: RoutesName.signeUpScreen),
      //     builder: (BuildContext context) => const SigneUpScreen(),
      //   );
      case RoutesName.resetPasswordScreen:
        final data = settings.arguments! as Map;
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutesName.resetPasswordScreen),
          builder: (BuildContext context) => ResetPasswordScreen(
            email: data['emailId'],
            token: data['token'],
          ),
        );

      // case RoutesName.otpVerificationScreen:
      //   final data = settings.arguments! as Map;
      //   return MaterialPageRoute(
      //     settings: const RouteSettings(name: RoutesName.otpVerificationScreen),
      //     builder: (BuildContext context) => OtpVerificationScreen(email: data['emailId'], otpVerificationType: data['otpVerificationType'],),
      //   );

      case RoutesName.forgotPasswordScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutesName.forgotPasswordScreen),
          builder: (BuildContext context) => ForgotPasswordScreen(),
        );

      case RoutesName.movieDetailScreen:
        final data = settings.arguments! as Map;
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutesName.movieDetailScreen),
          builder: (BuildContext context) => MovieDetailScreen(
            movieId: data['movieId'],
            imageUrl: data['imageUrl'], isDeepLinking: data['isDeepLinking'],
          ),
        );

      case RoutesName.seatLayoutScreen:
        final data = settings.arguments! as Map;
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutesName.seatLayoutScreen),
          builder: (BuildContext context) => SeatLayoutScreen(
            sessionId: data['sessionId'],
            cinemaId: data['cinemaId'],
            movieSelectionType: data['ShowTimeData'] as MovieSelectionType,
          ),
        );

      case RoutesName.offersScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutesName.offersScreen),
          builder: (BuildContext context) => const OffersScreen(),
        );

      case RoutesName.fAndBScreen:
        final data = settings.arguments! as Map;
        return MaterialPageRoute(
            settings: const RouteSettings(name: RoutesName.fAndBScreen),
            builder: (BuildContext context) {
              return FAndBScreen(
                reservationId: data['reservationId'] as String,
                sessionId: data['sessionId'] as String,
                cinemaId: data['cinemaId'] as String,
                postConcessionUrl: data['postConcessionUrl'] as String,
                fAndBType: data['fAndBType'],
              );
            });

      case RoutesName.orderConfirmationScreen:
        final data = settings.arguments! as Map;
        return MaterialPageRoute(
          settings:
              const RouteSettings(name: RoutesName.orderConfirmationScreen),
          builder: (BuildContext context) => OrderConfirmationScreen(
            reservationId: data['reservationId'] as String,
            navigateToScreen: data['navigateToScreen'],
          ),
        );

      case RoutesName.directFnBOrderConfirmationScreen:
        final data = settings.arguments! as Map;
        return MaterialPageRoute(
          settings: const RouteSettings(
              name: RoutesName.directFnBOrderConfirmationScreen),
          builder: (BuildContext context) => DirectFnBOrderConfirmationScreen(
            reservationId: data['reservationId'] as String,
            fAndBType: data['fAndBType'],
          ),
        );

      case RoutesName.directFnBSelectionScreen:
        final data = settings.arguments! as Map;
        return MaterialPageRoute(
          settings:
              const RouteSettings(name: RoutesName.directFnBSelectionScreen),
          builder: (BuildContext context) => DirectFnbSelectionScreen(
              reservationId: data['reservationId'] as String,
              sessionId: data['sessionId'] as String,
              cinemaId: data['cinemaId'] as String,
              postConcessionUrl: data['postConcessionUrl'] as String,
              fAndBType: data['fAndBType']),
        );

      case RoutesName.directFnBTakeawayScreen:
        return MaterialPageRoute(
          settings:
              const RouteSettings(name: RoutesName.directFnBTakeawayScreen),
          builder: (BuildContext context) => const TakeAwayFnbBookingScreen(),
        );

      case RoutesName.directFnBSummaryScreen:
        final data = settings.arguments! as Map;
        return MaterialPageRoute(
          settings:
              const RouteSettings(name: RoutesName.directFnBSummaryScreen),
          builder: (BuildContext context) => DirectFnbSummaryScreen(
            reservationId: data['reservationId'] as String,
            fAndBType: data['fAndBType'],
          ),
        );

      case RoutesName.ticketListScreen:
        final data = settings.arguments! as Map;
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutesName.ticketListScreen),
          builder: (BuildContext context) => TicketListScreen(
            reservationId: data['reservationId'] as String,
            isDeepLinking: data['isDeepLinking'] as bool,
          ),
        );

      case RoutesName.userProfileScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutesName.userProfileScreen),
          builder: (BuildContext context) => const UserProfileScreen(),
        );

      case RoutesName.dashboardScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutesName.dashboardScreen),
          builder: (BuildContext context) => const DashboardScreen(),
        );

      case RoutesName.bookingHistoryScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutesName.bookingHistoryScreen),
          builder: (BuildContext context) => const BookingHistoryScreen(),
        );

      case RoutesName.giftCardsScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutesName.giftCardsScreen),
          builder: (BuildContext context) => const GiftCardScreen(),
        );

      case RoutesName.showTimeScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutesName.showTimeScreen),
          builder: (BuildContext context) =>  const ShowTimeScreen(),
        );



      case RoutesName.sendGiftCardScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutesName.sendGiftCardScreen),
          builder: (BuildContext context) => const SendGiftCardScreen(),
        );

      case RoutesName.checkGiftCardsBalanceScreen:
        return MaterialPageRoute(
          settings:
              const RouteSettings(name: RoutesName.checkGiftCardsBalanceScreen),
          builder: (BuildContext context) => const CheckGiftCardBalanceScreen(),
        );
      case RoutesName.settingScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutesName.settingScreen),
          builder: (BuildContext context) => const SettingScreen(),
        );
      case RoutesName.locationsScreen:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RoutesName.locationsScreen),
            builder: (BuildContext context) => const LocationScreenByCity());


      case RoutesName.addGiftCardsBalanceScreen:
        final data = settings.arguments! as Map;
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutesName.addGiftCardsBalanceScreen),
          builder: (BuildContext context) => AddGiftCardBalance(
              appBarTitle: data['appBarTitle'] as String,
              title: data['title'] as String,
              subTitle: data['subTitle'] as String,
              showQuantity: data['showQuantity'] as bool),
        );

      case RoutesName.topUpGiftCardsScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutesName.topUpGiftCardsScreen),
          builder: (BuildContext context) => const TopUpGiftCard(),
        );

      case RoutesName.giftCardOrderSummeryScreen:
        return MaterialPageRoute(
          settings:
              const RouteSettings(name: RoutesName.giftCardOrderSummeryScreen),
          builder: (BuildContext context) => const GiftCardOrderSummery(),
        );

      case RoutesName.userProfileDetailsScreen:
        return MaterialPageRoute(
          settings:
              const RouteSettings(name: RoutesName.userProfileDetailsScreen),
          builder: (BuildContext context) => UserProfileDetailsScreen(),
        );

      case RoutesName.moviesScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutesName.moviesScreen),
          builder: (BuildContext context) => const MoviesScreen(),
        );

      case RoutesName.customWebViewScreen:
        final data = settings.arguments! as Map;
        return MaterialPageRoute(
            settings: const RouteSettings(name: RoutesName.customWebViewScreen),
            builder: (BuildContext context) =>
                CustomInAppWebView(url: data['Url']));

      case RoutesName.searchScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SearchScreen(),
        );

      case RoutesName.experiencesDetailScreen:
        final data = settings.arguments! as Map;
        return MaterialPageRoute(
          builder: (BuildContext context) => ExperienceDetailsScreen(experienceId: data['id'],),
        );

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(child: Text("Default")),
            );
          },
        );
    }
  }
}
