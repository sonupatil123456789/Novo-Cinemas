import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:novocinema/core/constants/ApiUrlConstants.dart';
import 'package:novocinema/core/restServices/BaseApi.dart';
import 'package:novocinema/core/restServices/NetworkApi.dart';
import 'package:novocinema/src/AncillaryPages/di/injectAncillaryPages.dart';
import 'package:novocinema/src/Auth/di/InjectAuth.dart';
import 'package:novocinema/src/BookingHistory/di/injectBookingHistory.dart';
import 'package:novocinema/src/Cinema-Experience/di/injectexperience.dart';
import 'package:novocinema/src/Dashboard/di/injectDashboard.dart';
import 'package:novocinema/src/DirectFnB/di/injectDirectFAndB.dart';
import 'package:novocinema/src/F&B/di/injectF&B.dart';
import 'package:novocinema/src/GiftCard/di/injectGiftCard.dart';
import 'package:novocinema/src/Home/di/injectHome.dart';
import 'package:novocinema/src/Location/di/injectLocation.dart';
import 'package:novocinema/src/MovieDetails/di/injectMovie.dart';
import 'package:novocinema/src/Movies/di/injectMovies.dart';

import 'package:novocinema/src/Offers/di/injectOffers.dart';
import 'package:novocinema/src/OrderConfirmation/di/injectOrderConfirmation.dart';
import 'package:novocinema/src/Payment/di/payment_di.dart';
import 'package:novocinema/src/Search/di/injectSearch.dart';
import 'package:novocinema/src/SeatLayout/di/injectSeatLayout.dart';
import 'package:novocinema/src/ShowTime/di/injectShowTime.dart';
import 'package:novocinema/src/Tickets/di/injectTicket.dart';
import 'package:novocinema/src/UserProfile/di/injectUserProfile.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'core/resources/SeassionManager.dart';

final GetIt getIt = GetIt.instance;

void init() {
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(
      baseUrl: ApiUrlConstants.BASE_URL,
      // connectTimeout: const Duration(seconds: 20),
      // receiveTimeout: const Duration(seconds: 20),
      // sendTimeout: const Duration(seconds: 20),
    ));

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      ));
    }
    return dio;
  });

  // Register NetworkApi, which depends on Dio
  getIt.registerLazySingleton<BaseApi>(() => NetworkApi(getIt<Dio>()));

  getIt.registerLazySingleton(() => SeassionManager());

  getIt.registerLazySingleton(() => FirebaseAuth.instance);

  getIt.registerLazySingleton(() => GoogleSignIn());

  getIt.registerLazySingleton(() => FacebookAuth.instance);

  injectAuth();
  injectHome();
  injectSearch();
  injectMovieDetails();
  injectMovies();
  injectSeatLayout();
  injectOffers();
  injectFAndB();
  injectOrderConfirmation();
  injectTicket();
  injectUserProfile();
  injectDashboard();
  injectBookingHistory();
  injectDirectFAndB();
  injectLocation();
  injectCinemaExperience();
  injectGiftCard();
  injectShowTime();
  injectPayment();
  injectAncillaryPages();
}
