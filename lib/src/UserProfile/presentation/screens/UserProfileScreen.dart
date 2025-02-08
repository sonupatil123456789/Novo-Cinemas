import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:novocinema/bloc/ApplicationBloc.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/GiftCard/presentation/bloc/GiftCardBloc.dart';
import 'package:novocinema/src/UserProfile/presentation/bloc/UserProfileBloc.dart';
import 'package:novocinema/src/UserProfile/presentation/screens/UserProfileDetailsScreen.dart';
import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/cards/UserProfileCard.dart';
import '../../../../core/constants/ImageConstants.dart';
import '../../../../core/constants/RoutesName.dart';
import '../../../Dashboard/presentation/screens/DashboardScreen.dart';
import '../../../GiftCard/presentation/screens/GiftCardsScreen.dart';
import '../../../Wallet/screens/my_wallet.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> with TickerProviderStateMixin {
  late TabController _languageTabController;



  @override
  void initState() {
    context.read<GiftCardBloc>().add(const GetSendReceivedGiftCardsEvent());
    _languageTabController = TabController(length: supportedLanguages.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ArtBoard(
      header: BackButtonNavBar(
        onBackPress: () {
          Navigator.pop(context);
        },
        center: Container(
          height: double.infinity,
          child: Row(
            children: [
              Text(
                'User Profile',
                style: context.textThemeDecoration.titleSmall
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: context.getScreenHeight(2)),
            const UserProfileCard(),
            SizedBox(height: context.getScreenHeight(2)),
            BlocBuilder<UserProfileBloc, UserProfileState>(
              builder: (context, userProfileState) {
                return SizedBox(
                  height: context.getScreenHeight(5),
                  child: ListView.separated(
                    itemCount: settings.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      final setting = settings[index];
                      final isSelected = userProfileState.selectedSetting == index;

                      return GestureDetector(
                        onTap: () {
                          context.read<UserProfileBloc>().add(SetSettingsChanged(index));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected? context.colorPalette.accentColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: context.colorPalette.accentColor),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                setting.iconAsset,
                                width: context.getScreenWidth(4),
                                height: context.getScreenWidth(4),
                                color: isSelected ? context.colorPalette.blackColor : context.colorPalette.whiteColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                setting.title,
                                style: context.textThemeDecoration.subTitleSmall.copyWith( color: isSelected ? context.colorPalette.blackColor : context.colorPalette.whiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>const SizedBox(width: 8),
                  ),
                );
              },
            ),
            SizedBox(height: context.getScreenHeight(2)),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(context.getScreenWidth(1)),
                child: BlocBuilder<UserProfileBloc, UserProfileState>(
                  builder: (context, userProfileState) {
                    return SingleChildScrollView(child: settings[userProfileState.selectedSetting].component);
                  },
                ),
              ),
            )







            // BlocBuilder<ApplicationBloc,ApplicationState>(
            //   builder: (BuildContext context, ApplicationState state) {
            //     return CustomTabBar<Locale>(
            //       tabPageIndex: (TabBarData<Locale> selected,int int ) {
            //         context.read<ApplicationBloc>().add(SetLocalEvent(selected.data!));
            //
            //       },
            //       dataList: supportedLanguages.map((local)=> TabBarData<Locale>(local.hashCode, local.languageCode, local)).toList(),
            //       selectedTab: TabBarData<Locale>(state.locale.hashCode, state.locale!.languageCode, state.locale),
            //       controller: _languageTabController,);
            //
            // },),

            // BlocBuilder<ApplicationBloc,ApplicationState>(
            //   builder: (BuildContext context, ApplicationState state) {
            //     return Switch(value: false,  onChanged: (bool value) {
            //       print("value ====================+++++$value");
            //     },);
            //
            //   },),

            // ...supportedLanguages.map((toElement){
            //   return GestureDetector(
            //     onTap: (){
            //       context.read<ApplicationBloc>().add(SetLocalEvent(toElement));
            //     }, child: Text(toElement.languageCode)
            //   );
            // })
          ],
        ),
      ),
    );
  }
}

final List<Setting> settings = [

  Setting('My Dashboard', ImageConstants.settingsDashboard, RoutesName.dashboardScreen,const DashboardScreen()),
  Setting("My Wallet", ImageConstants.settingsWallet, RoutesName.walletScreen,const DashboardScreen()),
  Setting('My Favourite Locations', ImageConstants.settingsLocation, RoutesName.locationsScreen,const DashboardScreen()),
  Setting('My Cards', ImageConstants.settingsCard, RoutesName.myCardsScreen,const DashboardScreen()),
  Setting('My Preference', ImageConstants.settingsHistory, RoutesName.bookingHistoryScreen,const DashboardScreen()),
  Setting('My Wallet', ImageConstants.settingsCard, RoutesName.myCardsScreen,const MyWallet()),
  Setting('Gift Cards', ImageConstants.gift, RoutesName.giftCardsScreen,const GiftCardsScreen()),
  Setting('My Profile', ImageConstants.settingsProfile, RoutesName.userProfileDetailsScreen,UserProfileDetailsScreen()),
];

class Setting {
  String title;
  String iconAsset;
  String navigationRouteName;
  Widget component ;

  Setting(this.title, this.iconAsset, this.navigationRouteName, this.component);
}
