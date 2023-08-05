import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wilson_wings/utils/colors.dart';
import 'package:wilson_wings/view_models/sign_in_screen_bloc/sign_in_screen_bloc.dart';

class WilsonTextFormField extends StatelessWidget {
  final String hint;
  final Icon? prefixIcon;
  final String fieldName;
  final bool? isDigitsOnly;
  final TextEditingController controller;

  const WilsonTextFormField(
      {super.key,
      required this.hint,
      this.prefixIcon,
      required this.fieldName,
      this.isDigitsOnly,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 1,
      validator: (value) {
        if (value!.isEmpty) {
          return '$fieldName Field is Empty';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: Adaptive.h(2)),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: Adaptive.w(2), right: Adaptive.w(1)),
            child: prefixIcon,
          ),
          prefixIconColor: primaryColor,
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: textFormFieldColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: textFormFieldColor)),
          filled: true,
          fillColor: textFormFieldColor,
          hintStyle: TextStyle(color: hintColor)),
      style: const TextStyle(color: Colors.white),
    );
  }
}

class WilsonPasswordTextFormField extends StatelessWidget {
  final String hint;
  final Icon? prefixIcon;
  final TextEditingController passwordController;

  const WilsonPasswordTextFormField(
      {super.key,
      required this.hint,
      this.prefixIcon,
      required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInScreenBloc, SignInScreenState>(
      buildWhen: (previous, current) => current is! SignInScreenActionState,
      builder: (context, state) {
        bool obsureValue;
        if (state is ObscureValueChangedState) {
          obsureValue = state.obscureValue;
        } else {
          obsureValue = true;
        }

        return TextFormField(
          controller: passwordController,
          maxLines: 1,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Password Field is Empty';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obsureValue,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: Adaptive.h(2)),
              prefixIcon: Padding(
                padding:
                    EdgeInsets.only(left: Adaptive.w(2), right: Adaptive.w(1)),
                child: prefixIcon,
              ),
              prefixIconColor: primaryColor,
              hintText: hint,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(color: textFormFieldColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(color: textFormFieldColor)),
              filled: true,
              fillColor: textFormFieldColor,
              hintStyle: TextStyle(color: hintColor),
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: Adaptive.w(1.5)),
                child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      BlocProvider.of<SignInScreenBloc>(context).add(
                          ObscureValueChangedEvenet(currentValue: obsureValue));
                    },
                    child: obsureValue
                        ? Icon(
                            Icons.visibility,
                            color: hintColor,
                            size: 23,
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: hintColor,
                            size: 23,
                          )),
              )),
          style: const TextStyle(color: Colors.white),
        );
      },
    );
  }
}
