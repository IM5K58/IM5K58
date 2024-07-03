import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home_screen.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: const Color(0XFFE7626C),
        textTheme:  TextTheme(
          headline1: TextStyle(
            color: Color(0XFF232B55),
          ),
        ),
        cardColor: const Color(0XFFF4EDDB),
      ),

      home: HomeScreen(),

    );
  }
}
