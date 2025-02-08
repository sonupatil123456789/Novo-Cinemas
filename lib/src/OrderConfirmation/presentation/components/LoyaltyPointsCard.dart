import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/theams/Utils.dart';

import '../../../../core/resources/AppException.dart';
import '../../../Auth/presentation/bloc/AuthBloc.dart';

class LoyaltyPointsCard extends StatefulWidget {
  const LoyaltyPointsCard({super.key});

  @override
  State<LoyaltyPointsCard> createState() => _LoyaltyPointsCardState();
}

class _LoyaltyPointsCardState extends State<LoyaltyPointsCard> {
  @override
  void initState() {
    final userData = context.read<AuthBloc>().state.user;
    if (userData == null) {
      context.read<AuthBloc>().add(GetUserDetailsEvent(onFailure: (AppException error) {

      }, onSuccess: (){

      }));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return SizedBox(
          width: context.getScreenWidth(90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("My Loyalty Points - ",
                  style: context.textThemeDecoration.subTitleMedium
                      .copyWith(color: context.colorPalette.accentColor, fontSize: 18)),
              const SizedBox(height: 5),
              Container(
                width: context.getScreenWidth(90),
                decoration: BoxDecoration(
                  color: context.colorPalette.accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child:  Row(
                  children: [
                    Icon(Icons.info_outline, color: context.colorPalette.accentColor, size: 20),
                    const SizedBox(width: 6),
                    Text("1 Loyalty Point = ${state.email}",
                        style: context.textThemeDecoration.subTitleSmall
                            .copyWith(color: context.colorPalette.accentColor, fontSize: 16)),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
