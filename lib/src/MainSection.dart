import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:novocinema/bloc/ApplicationBloc.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/Cinema-Experience/presentation/bloc/cinema_experience_bloc.dart';
import 'package:novocinema/src/DirectFnB/presentation/screens/DirectFnbBookingScreen.dart';
import 'package:novocinema/src/F&B/presentation/screens/FAndBScreen.dart';
import 'package:novocinema/src/Home/presentation/screens/HomeScreen.dart';
import 'package:novocinema/src/PrivateBooking/presentation/screens/private_screen.dart';
import '../components/AppBarSection.dart';
import '../components/ArtBoard.dart';
import '../components/BottomNavigationBarSection.dart';
import '../components/ConformationPopUp.dart';
import 'AncillaryPages/presentation/bloc/AncillaryPagesBloc.dart';
import 'AncillaryPages/presentation/screens/ExperiencesScreen.dart';
import 'AncillaryPages/presentation/screens/OffersScreen.dart';
import 'Cinema-Experience/presentation/bloc/cinema_experience_event.dart';
import 'Home/presentation/bloc/HomeBloc.dart';
import 'Movies/presentation/bloc/MoviesBloc.dart';
import 'Movies/presentation/screens/MoviesScreen.dart';
import 'PrivateScreening/presentation/screens/PrivateBookingListScreen.dart';
import 'SideNavBar/presentation/screens/SideBarScreen.dart';

class MainSection extends StatefulWidget {
  const MainSection({super.key});

  @override
  State<MainSection> createState() => _MainSectionState();
}

class _MainSectionState extends State<MainSection> {
  final _controller = PageController(initialPage: 0);

  int selectedPage = 0;

  @override
  void initState() {
    super.initState();
    // PermissionService(context).requestLocationPermission(() {});
    context.read<ApplicationBloc>().add(const GetLocalUserDetailsEvent());
    context.read<ApplicationBloc>().add(const IsUserLogInEvent());
    context.read<MoviesBloc>().add(const GetAllFilteredMoviesEvent(<String, dynamic>{}));
    context.read<HomeBloc>().add(const GetAllBannersEvent());
    context.read<HomeBloc>().add(const GetQuickBookEvent(<String, dynamic>{}));
    context.read<AncillaryPagesBloc>().add(ExperiencesDataRequestEvent('experiences'));
    context.read<CinemaExperienceBloc>().add(const GetCinemaExperiencesEvent(null));
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const DirectFnbBookingScreen(fAndBType: FAndBType.QR_FNB),
    const OffersAndPromoScreen(),
    const ExperiencesScreen(),
    const PrivateBookingListScreen()
    // SideBarScreen()
    // const SeatLayoutScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return ArtBoard(
      header: AppBarSection(
        screenIndex: selectedPage,
      ),
      headerHeight: context.getScreenHeight(selectedPage == 0 ? 8 : 8),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (willpop, data) {
          conformationPopUp(
              context: context,
              title: 'Confirm Exit',
              content: 'Do you really want to exit app',
              onYes: () {
                if (context.isAndroid) {
                  SystemNavigator.pop();
                }
                if (context.isIOS) {
                  exit(0);
                }
              });
        },
        child: LiquidPullToRefresh(
          showChildOpacityTransition: false,
          springAnimationDurationInMilliseconds: 200,
          color: context.colorPalette.accentColor,
          backgroundColor: context.colorPalette.darkGreyColor,
          onRefresh: () async {
            context.read<MoviesBloc>().add(const GetAllFilteredMoviesEvent(<String, dynamic>{}));
            context.read<HomeBloc>().add(const GetAllBannersEvent());
          },
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            onPageChanged: (index) {
              setState(() {
                selectedPage = index;
              });
            },
            itemCount: _screens.length,
            controller: _controller,
            itemBuilder: (BuildContext context, int index) {
              return _screens[index];
            },
          ),
        ),
      ),
      footerLocation: FloatingActionButtonLocation.miniCenterDocked,
      footer: BottomNavigationBarSection(
        item: (int index) {
          _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        selectedItem: selectedPage,
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ArtBoard(
        body: const Center(
      child: Text("ABOUT SECTION"),
    ));
  }
}

// class PrivateBookingScreen extends StatelessWidget {
//   const PrivateBookingScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ArtBoard(
//         body: const Center(
//       child: Text("PRIVATE BOOKING SECTION"),
//     ));
//   }
// }

// canPop: false,
// onPopInvokedWithResult: (willpop, data) {
// conformationPopUp(
// context: context,
// title: 'Confirm Exit',
// content: 'Do you really want to exit app',
// onYes: () {
// if (context.isAndroid) {
// SystemNavigator.pop();
// }
// if (context.isIOS) {
// exit(0);
// }
// });
// },
