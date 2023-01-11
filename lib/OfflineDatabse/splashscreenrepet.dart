import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'Homepage.dart';

class splashscreenrepet extends StatefulWidget {
  const splashscreenrepet({Key? key}) : super(key: key);

  @override
  State<splashscreenrepet> createState() => _splashscreenrepetState();
}

class _splashscreenrepetState extends State<splashscreenrepet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fornavigation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
        body: Center(child: Lottie.asset("animation/new.json"),),
    );
  }

  void fornavigation() {
    Future.delayed(Duration(seconds: 4)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HHH();
      },));
    });
  }
}
