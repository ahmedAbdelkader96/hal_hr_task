import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:task/features/authentication/controller/controller.dart';
import 'package:task/features/menu/widgets/general_profile_button.dart';
import 'package:task/global/methods_helpers_functions/Isolates.dart';
import 'package:task/global/methods_helpers_functions/toast.dart';
import 'package:task/global/navigation_routes/routes.dart';

import '../bloc/menu_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuBloc, MenuState>(
      listener: (context, state) {
        if (state is ErrorToSignOutState) {
          ToastClass.toast(context: context, data: state.message, seconds: 3);
          debugPrint(state.message);
        }

        if (state is DoneToSignOutState) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            Routes.splashScreen(context: context);
          });
        }
      },
      builder: (context, state) {
        return GeneralProfileButton(
          onPressed: () async{
            //6804e4c5b9977596279f7119
            context.read<MenuBloc>().add(SignOut());
            //Isolates.executeSendNotificationInBackground(false,"6804e4c5b9977596279f7119");

            // await OneSignal.logout();
            // await AuthController().createOneSignalUser(externalId: "22222222222");
            // await OneSignal.login("22222222222");
             //await OneSignal.User.addAlias("external_id", "6804e4c5b9977596279f7119");
           //await OneSignal.User.;
          },
          title: "LogOut",
          isLoading: state is LoadingToSignOutState,
          child: SvgPicture.asset('assets/images/logout.svg'),
        );
      },
    );
  }
}
