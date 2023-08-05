import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wilson_wings/utils/colors.dart';
import 'package:wilson_wings/view_models/splash_screen_bloc/splash_screen_bloc.dart';
import 'package:wilson_wings/views/screens/screen_login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SplashScreenBloc>(context)
        .add(NavigateToLoginScreenEvent());
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: backgroundColor),
        child: Scaffold(
          body: SafeArea(
              child: BlocListener<SplashScreenBloc, SplashScreenState>(
            listenWhen: (previous, current) =>
                current is SplashScreenActionState,
            listener: (context, state) {
              if (state is NavigateToLoginScreenState) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              }
            },
            child: const Center(
              child: Text('Wilson Wings',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          )),
        ));
  }
}
