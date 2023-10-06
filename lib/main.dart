import 'package:flutter/material.dart';
import 'package:joke/joke.dart';
import 'package:joke/signup_screen.dart';
import 'login_screen.dart';

void main()
{
  runApp(MyApp());
}

class MyApp  extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      initialRoute: LoginScreen.id,
      routes: {
        SignUpScreen.id:(context)=>SignUpScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        JokeList.id:(context) =>JokeList(),
      },
    );

  }
}

