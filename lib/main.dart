import 'package:ar_furniture_app/screens/home_screen.dart';
import 'package:ar_furniture_app/screens/splash_scree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  } catch (errorMsg) {
    print("Error" + errorMsg.toString());
  }
  runApp(const IKEA());
}

class IKEA extends StatelessWidget {
  const IKEA({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const SplashScreen(),
    );
  }
}
