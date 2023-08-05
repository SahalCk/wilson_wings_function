// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wilson_wings/utils/colors.dart';
import 'package:wilson_wings/utils/sized_boxes.dart';
import 'package:wilson_wings/utils/text_styles.dart';
import 'package:wilson_wings/view_models/sign_in_screen_bloc/sign_in_screen_bloc.dart';
import 'package:wilson_wings/views/screens/screen_home.dart';
import 'package:wilson_wings/views/screens/screen_signup.dart';
import 'package:wilson_wings/views/widgets/wilson_elevated_button.dart';
import 'package:wilson_wings/views/widgets/wilson_snack_bars.dart';
import 'package:wilson_wings/views/widgets/wilson_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final _key = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Adaptive.w(7)),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  sizedBoxHeight140,
                  sizedBoxHeight100,
                  const Text('Login', style: loginTextStyle),
                  sizedBoxHeight60,
                  WilsonTextFormField(
                      hint: 'Enter Email',
                      fieldName: 'Email',
                      prefixIcon: const Icon(Icons.mail_rounded, size: 25),
                      controller: emailController),
                  sizedBoxHeight20,
                  WilsonPasswordTextFormField(
                      hint: 'Enter Password',
                      prefixIcon: const Icon(Icons.lock, size: 25),
                      passwordController: passwordController),
                  sizedBoxHeight60,
                  BlocListener<SignInScreenBloc, SignInScreenState>(
                    listenWhen: (previous, current) =>
                        current is SignInScreenActionState,
                    listener: (context, state) {
                      if (state is LoginSuccessState) {
                        Navigator.of(context).pop();
                        successSnackBar(context, 'Login Successfull');
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                      } else if (state is LoginErrorState) {
                        Navigator.of(context).pop();
                        errorSnackBar(context, state.error);
                      }
                    },
                    child: WilsonElevatedButton(
                        function: () {
                          if (_key.currentState!.validate()) {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => Center(
                                      child: CircularProgressIndicator(
                                          backgroundColor: const Color.fromARGB(
                                              255, 207, 234, 255),
                                          color: primaryColor,
                                          strokeWidth: 6),
                                    ));
                            BlocProvider.of<SignInScreenBloc>(context).add(
                                LoginButtonPressedEvent(
                                    email: emailController.text,
                                    password: passwordController.text));
                          }
                        },
                        text: 'Login'),
                  ),
                  sizedBoxHeight140,
                  sizedBoxHeight120,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0)),
                          child: const Text('Register'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
