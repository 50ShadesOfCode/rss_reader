import 'package:flutter/material.dart';
import 'package:untitled/domain/init.dart';
import 'package:untitled/presentation/splashscreen.dart';
import 'package:untitled/presentation/tabview.dart';

final Future _initFuture = Init.initialize();

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return TabView();
          } else {
            return const SplashScreen();
          }
        },
      ),
    );
  }
}
