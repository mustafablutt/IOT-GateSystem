import 'package:flutter/material.dart';
import 'package:gatesystem/pages/home_page.dart';
import 'package:gatesystem/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gatesystem/pages/sign_up.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        "/loginPage": (context) => LoginPage(),
        "/signUp": (context) => SignUp(),
        "/homePage": (context) => HomePage(),

      },
      theme: ThemeData(

      ),
      home: Scaffold(
        body: LoginPage(),
      ),
    );
  }
}