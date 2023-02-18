import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import '../screens/age.dart';
import '../screens/gender.dart';
import '../screens/home.dart';
import '../screens/login.dart';
import '../screens/tab_bar.dart';
import '../utils/colors_util.dart';

class OnBoarding3Screen extends StatelessWidget {
  static const routeName = '/onboarding3';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor('ffffff'),
              hexStringToColor('ffffff'),
              hexStringToColor('ffffff'),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  left: 15, bottom: 10, right: 15, top: 50),
            ),
            CircleAvatar(
              radius: 200,
              backgroundImage:
                  AssetImage('assets/images/onboarding/onboarding_3.png'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Cardio',
              style: TextStyle(
                  fontSize: 40,
                  color: Color(0xFF4c53A5),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                  letterSpacing: 0.5),
            ),
            SizedBox(
              height: 55.0,
            ),
            Center(
              child: DotsIndicator(
                dotsCount: 3,
                position: 2,
                decorator: DotsDecorator(
                  spacing: const EdgeInsets.all(10.0),
                  activeColor: Color(0xFF4c53A5),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: 350,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(HomePage.routeName);
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: Color(0xFF4c53A5),
                ),
                child: Text(
                  'Tiep Theo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    letterSpacing: 0.5,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
