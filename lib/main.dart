import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_inmakes/Screens/bottom_navigation.dart';
import 'package:project_inmakes/Screens/order_list.dart';
import 'package:provider/provider.dart';
import 'package:project_inmakes/Screens/Home.dart';
import 'package:project_inmakes/Screens/Like.dart';
import 'package:project_inmakes/Screens/Login.dart';
import 'package:project_inmakes/Screens/Register.dart';
import 'package:project_inmakes/Screens/baby_kidz.dart';
import 'package:project_inmakes/Screens/profile.dart';
import 'package:project_inmakes/Screens/shopping_cart.dart';
import 'package:project_inmakes/Screens/splash.dart';
import 'package:project_inmakes/provider/cart_provider.dart';
import 'firebase_options.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => Splash(),
        "/Login": (context) => Login(),
        "/Register": (context) => Register(),
        "/Home": (context) => Home(),
        "/Profile": (context) => Profile(),
        "/Like": (context) => Like(),
        "/Cart": (context) => ShoppingCart(),
        "/Baby&kidz": (context) => BabyKidz(),
         "/MyHomePage": (context) => MyHomePage(),
                  "/OrderList": (context) => OrderList(),

      },
    );
  }
}
