import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../screens/onboarding1.dart';
import '../utils/colors_util.dart';

class LoadingScreen extends StatefulWidget {
  static const routeName = '/loading';
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(seconds: 2), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => OnBoarding1Screen()));
  }

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
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                bottom: 60,
                right: 15,
                top: 40,
              ),
              child: Image.asset(
                "assets/images/logo8.png",
                height: 310,
                width: 400,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: SpinKitFadingCircle(
                color: Color(0xFF4c53A5),
                size: 100,
              ),
            )
          ],
        ),
      ),
    );
  }
}
