import 'package:flutter/material.dart';
import 'package:work_options/constants/constants.dart' as constants;

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  final String releaseVersion = "1.0.0";

  Widget _splashBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          constants.splashImage,
          height: 400,
        ),
        const SizedBox(height: 20),
        const Text(
          constants.splashText, 
          style: TextStyle(
            fontSize: 30 
          )
        ),
        const SizedBox(height: 10),
        const Text(
          '.....' ,
          style: TextStyle(
            fontSize: 40
          )
        ),
        const Spacer(),
        const Text(
          'release',          
        ),
        Text(releaseVersion),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _splashBody(),
    );
  }
}
