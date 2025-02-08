import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/bloc/ApplicationBloc.dart';
import 'package:novocinema/core/resources/AppException.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/core/utils/ListnerUtils.dart';
import 'package:novocinema/src/Auth/presentation/bloc/AuthBloc.dart';
import '../../../../components/CustomButton.dart';
import '../../../../components/HeaderTextOne.dart';
import '../../../../core/constants/RoutesName.dart';

class UserProfileDetailsScreen extends StatelessWidget {
  UserProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderTextOne(
          title: 'User Profile',
        ),
        BlocBuilder<ApplicationBloc,ApplicationState>(
          builder: (BuildContext context,  state) {
            return Column(
              children: [
                userData(context, "User Name : ", state.userDetails?.userName),
                userData(context, "Full Name : ", '${state.userDetails?.userFirstName} ${state.userDetails?.userLastName}'),
                userData(context, "Email : ", state.userDetails?.userEmail),
                userData(context, "Contact : ", state.userDetails?.userContact),

              ],
            );
          },),
        const SizedBox(
          height: 30,
        ),
        CustomButton(
          height: context.getScreenHeight(6),
          backgroundColor: context.colorPalette.error,
          iconSpacing: 10,
          text: 'Logout',
          textColor: context.colorPalette.textColor,
          onTap: () async {
            context.read<AuthBloc>().add(LogOutEvent(onSuccess: () {
              Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesName.mainSection,
                      (route) =>
                  route.settings.name == RoutesName.mainSection);
            }, onFailure: (AppException error) {
              ListnersUtils.showErrorMessage(
                  'Logging out failed. Please try again',
                  'Logout Error',
                  context);
            }));
          },
          width: context.getScreenWidth(40),
        ),
      ],
    );
  }

  Widget userData(BuildContext context, String title, String? data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: context.getScreenWidth(30),
            child: Text(
              title,
              style: context.textThemeDecoration.subTitleLarge.copyWith(
                color: context.colorPalette.accentColor,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            child: Text(
              data ?? '',
              style: context.textThemeDecoration.subTitleLarge.copyWith(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }
}
