import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/bloc/ApplicationBloc.dart';
import 'package:novocinema/core/theams/Utils.dart';
import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../core/constants/DatabaseKeyConstants.dart';
import '../../../../core/constants/ImageConstants.dart';
import '../../../../core/constants/RoutesName.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/SeassionManager.dart';
import '../../../../core/utils/ListnerUtils.dart';
import '../../../Auth/presentation/bloc/AuthBloc.dart';
import '../../../Auth/presentation/screens/LoginScreen.dart';




class SideBarScreen extends StatelessWidget {

  final BorderRadius borderRadius = BorderRadius.circular(12);

   SideBarScreen({super.key});



  @override
  Widget build(BuildContext context) {


    return ArtBoard(
      header: BackButtonNavBar(onBackPress: () {Navigator.pop(context);},
        center: Container(
          height: double.infinity,
          child: Row(
            children: [
              Text('Menu', style: context.textThemeDecoration.titleSmall.copyWith(
                  fontWeight: FontWeight.bold
              ),),
              const Spacer(),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: [

                  ...List.generate(sideNavigationBar.length, (index){
                    final setting = sideNavigationBar[index];
                      return sideBarCard(context: context, onPress: (){
                        if(setting.requiredAuth){
                          context.read<AuthBloc>().add(AuthenticateUserEvent(
                              onSuccess: () {
                                navigateToUserProfile(context,setting.navigationRouteName);
                              },
                              onFailure: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        settings: const RouteSettings(name: RoutesName.loginScreen),
                                        builder: (context) {
                                          return LogInScreen(onLogin: (bool isLogin) {
                                            navigateToUserProfile(context,setting.navigationRouteName);
                                          });
                                        }));
                              }));

                        }
                        else {
                          Navigator.pushNamed(context, setting.navigationRouteName);
                        }
                      }, name: setting.title, icon: setting.iconAsset, colour: context.colorPalette.whiteColor);
                  }),
                  BlocBuilder<ApplicationBloc,ApplicationState>(
                    builder: (BuildContext context,  state) {

                      if(state.isUserLogIn!){
                        return sideBarCard(context: context, onPress: (){
                          context.read<AuthBloc>().add(LogOutEvent(onSuccess: (){
                            context.read<ApplicationBloc>().add(const SetIsUserLogInEvent(false));
                            navigateToUserProfile(context,RoutesName.mainSection);
                          }, onFailure: ( AppException error){
                            ListnersUtils.showErrorMessage('Logging out failed. Please try again', 'Logout Error', context);
                          }));

                        },
                            name: 'Logout', icon: ImageConstants.logout,
                            colour: context.colorPalette.errorColor);
                      }else {
                        return const SizedBox.shrink();
                      }



                    },)

                  // StreamBuilder<bool>(stream:session.tokenStatusStream ,
                  //   builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  //    // print('=====================${session.tokenStatusStream.hashCode}==============702577181==========+${snapshot.data}');
                  //
                  //   if( snapshot.connectionState == ConnectionState.active && snapshot.hasData && snapshot.data == true){
                  //     return sideBarCard(context: context, onPress: (){
                  //       context.read<AuthBloc>().add(LogOutEvent(onSuccess: (){
                  //         navigateToUserProfile(context,RoutesName.mainSection);
                  //       }, onFailure: ( AppException error){
                  //         ListnersUtils.showErrorMessage('Logging out failed. Please try again', 'Logout Error', context);
                  //       }));
                  //
                  //     }, name: 'Logout', icon: ImageConstants.logout, colour: context.colorPalette.errorColor);
                  //   }else{
                  //     return const SizedBox.shrink();
                  //   }
                  // },)

                ]
              ),
            ]
        ),
      ),
    );
  }

  void navigateToUserProfile(BuildContext context,String screenName) {
    Navigator.pushNamedAndRemoveUntil(context, screenName,(route) => route.settings.name == RoutesName.sideBar);
  }

  // void logout(BuildContext context ){
  Widget sideBarCard({required BuildContext context , required Function onPress,
    required String name ,required String icon, required Color colour }){
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: context.getScreenWidth(100),
          height: context.getScreenHeight(6),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: context.colorPalette.lightGreyColor.withOpacity(0.6), width: 0.6)
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              SvgPicture.asset(
                icon,
                width: context.getScreenWidth(5),
                height: context.getScreenWidth(5),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: context.textThemeDecoration.subTitleSmall.copyWith(fontSize: 18, fontWeight: FontWeight.w400, color: colour),
              ),
              const Spacer(),
              Icon(Icons.chevron_right,size: context.getScreenWidth(5),),
              const SizedBox(width: 10,)
            ],
          ),
        ),
      ),
    );
  }
}

final List<SideNavigationData> sideNavigationBar = [
  SideNavigationData('Movies', ImageConstants.sidebarMovieIcon, RoutesName.moviesScreen, false),
  SideNavigationData('My Booking History', ImageConstants.settingsHistory,RoutesName.bookingHistoryScreen,true),
  SideNavigationData('Profile', ImageConstants.settingsProfile,RoutesName.userProfileScreen,true),
  SideNavigationData('Gift Card', ImageConstants.gift,RoutesName.giftCardsScreen,false),
  SideNavigationData('Show Time', ImageConstants.sidebarMovieIcon,RoutesName.showTimeScreen,false),
  SideNavigationData('Settings', ImageConstants.settings,  RoutesName.settingScreen, true),

];

class SideNavigationData {
  String title;
  String iconAsset;
  String navigationRouteName;
  bool requiredAuth ;

  SideNavigationData(this.title, this.iconAsset, this.navigationRouteName, this.requiredAuth );
}

