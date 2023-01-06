import 'package:apicalling/OfflineDatabse/Loginpagee.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MysplashScreen extends StatefulWidget {
  const MysplashScreen({Key? key}) : super(key: key);

  @override
  State<MysplashScreen> createState() => _MysplashScreenState();
}

class _MysplashScreenState extends State<MysplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return Loginpagee();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Lottie.asset("animation/loadin1g.json")),
    );
  }
}
