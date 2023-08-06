import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ConnectionLostLottie extends StatelessWidget {
  const ConnectionLostLottie({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            'animations/connection_lost.json',
            width: Adaptive.w(90),
          ),
          const Text('No Internet Connection!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromARGB(255, 238, 238, 238),
                  fontSize: 17,
                  fontWeight: FontWeight.bold)),
          const Text('Please Check Your Internet Connection',
              style: TextStyle(
                  color: Color.fromARGB(255, 158, 158, 158), fontSize: 13))
        ],
      ),
    );
  }
}
