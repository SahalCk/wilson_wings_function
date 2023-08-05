import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wilson_wings/utils/colors.dart';
import 'package:wilson_wings/view_models/sign_in_screen_bloc/sign_in_screen_bloc.dart';
import 'package:wilson_wings/view_models/sign_up_screen_bloc/sign_up_screen_bloc.dart';
import 'package:wilson_wings/view_models/splash_screen_bloc/splash_screen_bloc.dart';
import 'package:wilson_wings/views/screens/screen_splash.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const WilsonWings());
}

class WilsonWings extends StatelessWidget {
  const WilsonWings({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashScreenBloc()),
        BlocProvider(create: (context) => SignInScreenBloc()),
        BlocProvider(create: (context) => SignUpScreenBloc())
      ],
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            title: 'Wilson Wings',
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                    seedColor: primaryColor,
                    primary: primaryColor,
                    background: backgroundColor),
                useMaterial3: true),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
