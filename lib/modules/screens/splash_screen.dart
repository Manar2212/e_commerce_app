import 'package:e_commerce_app/layout/layout_screen.dart';
import 'package:e_commerce_app/modules/screens/auth_screens/register_screen.dart';
import 'package:e_commerce_app/modules/screens/home_screen.dart';
import 'package:e_commerce_app/modules/screens/profile_screen.dart';
import 'package:e_commerce_app/shared/network/local/local_network.dart';
import 'package:flutter/material.dart';

import '../../shared/constants/constants.dart';
import 'auth_screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    Future.delayed(
      Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context,token != null && token != 'there is no data' ? LayoutScreen.id : LoginScreen.id));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/images/—Pngtree—online shopping logo desing_8918925.png',width: 250,)),
        ],
      ),
    );
  }
}
