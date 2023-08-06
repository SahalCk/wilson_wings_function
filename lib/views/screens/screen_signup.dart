// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wilson_wings/utils/colors.dart';
import 'package:wilson_wings/utils/sized_boxes.dart';
import 'package:wilson_wings/utils/text_styles.dart';
import 'package:wilson_wings/view_models/sign_up_screen_bloc/sign_up_screen_bloc.dart';
import 'package:wilson_wings/views/screens/screen_home.dart';
import 'package:wilson_wings/views/screens/screen_login.dart';
import 'package:wilson_wings/views/widgets/wilson_connection_lost_widget.dart';
import 'package:wilson_wings/views/widgets/wilson_elevated_button.dart';
import 'package:wilson_wings/views/widgets/wilson_snack_bars.dart';
import 'package:wilson_wings/views/widgets/wilson_text_form_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final _key = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Adaptive.w(7)),
          child: StreamBuilder<ConnectivityResult>(
              stream: Connectivity().onConnectivityChanged,
              builder: (context, snapshot) {
                if (snapshot.data != ConnectivityResult.none &&
                    snapshot.data != null) {
                  return SingleChildScrollView(
                    child: BlocListener<SignUpScreenBloc, SignUpScreenState>(
                      listenWhen: (previous, current) =>
                          current is SignUpScreenActionState,
                      listener: (context, state) {
                        if (state is SignUpSuccessState) {
                          Navigator.of(context).pop();
                          successSnackBar(
                              context, 'Account Created Successfull');
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        } else if (state is SignUpFailedState) {
                          Navigator.of(context).pop();
                          errorSnackBar(context, state.error);
                        }
                      },
                      child: Form(
                        key: _key,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            sizedBoxHeight140,
                            sizedBoxHeight100,
                            const Text('Register', style: loginTextStyle),
                            sizedBoxHeight60,
                            WilsonTextFormField(
                                hint: 'Enter Email',
                                fieldName: 'Email',
                                prefixIcon:
                                    const Icon(Icons.mail_rounded, size: 25),
                                controller: emailController),
                            sizedBoxHeight20,
                            WilsonPasswordTextFormField(
                                hint: 'Enter Password',
                                prefixIcon: const Icon(Icons.lock, size: 25),
                                passwordController: passwordController),
                            sizedBoxHeight60,
                            WilsonElevatedButton(
                                function: () {
                                  if (_key.currentState!.validate()) {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) => Center(
                                              child: CircularProgressIndicator(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 207, 234, 255),
                                                  color: primaryColor,
                                                  strokeWidth: 6),
                                            ));
                                    BlocProvider.of<SignUpScreenBloc>(context)
                                        .add(SignUpButtonClickedEvent(
                                            email: emailController.text,
                                            password: passwordController.text));
                                  }
                                },
                                text: 'Register'),
                            sizedBoxHeight140,
                            sizedBoxHeight120,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account?",
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()));
                                    },
                                    style: TextButton.styleFrom(
                                        padding: const EdgeInsets.all(0)),
                                    child: const Text('Login'))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const ConnectionLostLottie();
                }
              }),
        ),
      ),
    );
  }
}
