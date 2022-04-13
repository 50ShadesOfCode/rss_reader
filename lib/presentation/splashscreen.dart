import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget{
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/rss.png"),
          const SizedBox(height: 20),
          const CircularProgressIndicator()
        ],
      ),
    );
  }
}