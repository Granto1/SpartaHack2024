import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:devapp/screens/mode1_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 50),
                Container(
                    height: 450,
                    width: 730.9063136,
                    child: Image.asset(
                      'assets/bluecat.png',
                    )),
                Container(
                  height: 100,
                  width: 350,
                  child: Image.asset('assets/logo.png'),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 350,
                  child: TextButton(
                    // style: ButtonStyle(
                    //   foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    // ),
                    style: flatButtonStyle,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ModeScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "PLAY!",
                      style: TextStyle(
                        fontSize: 60.0,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  width: 350,
                  child: TextButton(
                    // style: ButtonStyle(
                    //   foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    // ),
                    style: flatButtonStyle,
                    onPressed: () {},
                    child: const Text(
                      "",
                      style: TextStyle(
                        fontSize: 60.0,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    ));
  }
}

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  primary: Colors.blue,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);
