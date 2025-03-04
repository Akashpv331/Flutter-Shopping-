import 'dart:async';

import 'package:flutter/material.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushNamed(context, "/Login"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text("WELCOME"),),);
  }
}
