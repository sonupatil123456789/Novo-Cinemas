import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:novocinema/core/constants/RoutesName.dart';
import 'package:novocinema/src/AncillaryPages/presentation/bloc/AncillaryPagesBloc.dart';
import 'package:novocinema/src/Auth/presentation/bloc/AuthBloc.dart';
import 'package:novocinema/src/BookingHistory/presentation/bloc/BookingHistoryBloc.dart';
import 'package:novocinema/src/Cinema-Experience/presentation/bloc/cinema_experience_bloc.dart';
import 'package:novocinema/src/DirectFnB/presentation/bloc/DirectF&BBloc.dart';
import 'package:novocinema/src/F&B/presentation/bloc/F&BBloc.dart';
import 'package:novocinema/src/GiftCard/presentation/bloc/GiftCardBloc.dart';
import 'package:novocinema/src/Home/presentation/bloc/HomeBloc.dart';
import 'package:novocinema/src/Location/presentation/bloc/LocationBloc.dart';
import 'package:novocinema/src/MovieDetails/presentation/bloc/MovieDetailsBloc.dart';
import 'package:novocinema/src/Movies/presentation/bloc/MoviesBloc.dart';
import 'package:novocinema/src/Offers/presentation/bloc/OffersBloc.dart';
import 'package:novocinema/src/OrderConfirmation/presentation/bloc/OrderConfirmationBloc.dart';
import 'package:novocinema/src/Payment/presentation/blocs/payment_bloc.dart';
import 'package:novocinema/src/Search/presentation/bloc/SearchBloc.dart';
import 'package:novocinema/src/SeatLayout/presentation/bloc/SeatLayoutBloc.dart';
import 'package:novocinema/src/ShowTime/presentation/bloc/ShowTimeBloc.dart';
import 'package:novocinema/src/Tickets/presentation/bloc/TicketBloc.dart';
import 'package:novocinema/src/UserProfile/presentation/bloc/UserProfileBloc.dart';
import 'package:novocinema/src/UserProfile/presentation/screens/UserProfileScreen.dart';
import 'core/Routes/Routes.dart';
import 'core/localization/SetLocal.dart';
import 'core/nativeServices/DeepLinkServices.dart';
import 'di.dart';
import 'bloc/ApplicationBloc.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  // final Locale _locale = const Locale('en', '');

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    DeepLinkServices(context, navigatorKey).initDeepLinksService();
    // PushNotificationService(context, navigatorKey).initOnClickNotification();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => getIt<AuthBloc>(),
        ),
        BlocProvider<ApplicationBloc>(
          create: (BuildContext context) => ApplicationBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (BuildContext context) => getIt<HomeBloc>(),
        ),
        BlocProvider<MovieDetailsBloc>(
          create: (BuildContext context) => getIt<MovieDetailsBloc>(),
        ),
        BlocProvider<SeatLayoutBloc>(
          create: (BuildContext context) => getIt<SeatLayoutBloc>(),
        ),
        BlocProvider<FAndBBloc>(
          create: (BuildContext context) => getIt<FAndBBloc>(),
        ),
        BlocProvider<OffersBloc>(
          create: (BuildContext context) => getIt<OffersBloc>(),
        ),
        BlocProvider<SearchBloc>(
          create: (BuildContext context) => getIt<SearchBloc>(),
        ),
        BlocProvider<OrderConfirmationBloc>(
          create: (BuildContext context) => getIt<OrderConfirmationBloc>(),
        ),
        BlocProvider<TicketBloc>(
          create: (BuildContext context) => getIt<TicketBloc>(),
        ),
        BlocProvider<UserProfileBloc>(
          create: (BuildContext context) => getIt<UserProfileBloc>(),
        ),
        BlocProvider<BookingHistoryBloc>(
          create: (BuildContext context) => getIt<BookingHistoryBloc>(),
        ),
        BlocProvider<DirectFAndBBloc>(
          create: (BuildContext context) => getIt<DirectFAndBBloc>(),
        ),
        BlocProvider<MoviesBloc>(
          create: (BuildContext context) => getIt<MoviesBloc>(),
        ),
        BlocProvider<LocationBloc>(
          create: (BuildContext context) => getIt<LocationBloc>(),
        ),
        BlocProvider<CinemaExperienceBloc>(
          create: (BuildContext context) => getIt<CinemaExperienceBloc>(),
        ),
        BlocProvider<GiftCardBloc>(
          create: (BuildContext context) => getIt<GiftCardBloc>(),
        ),
        BlocProvider<ShowTimeBloc>(
          create: (BuildContext context) => getIt<ShowTimeBloc>()),
        BlocProvider<PaymentBloc>(
          create: (BuildContext context) => getIt<PaymentBloc>(),
        ),
        BlocProvider<AncillaryPagesBloc>(
          create: (BuildContext context) => getIt<AncillaryPagesBloc>(),
        ),

      ],
      child: BlocBuilder<ApplicationBloc, ApplicationState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Novo Cinema',
            debugShowCheckedModeBanner: false,
            locale: state.locale,
            supportedLocales: supportedLanguages,
            navigatorKey: navigatorKey,
            onGenerateRoute: Routes.generateRoutes,
            initialRoute: RoutesName.mainSection,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.system,
          );
        },
      ),
    );
  }
}
