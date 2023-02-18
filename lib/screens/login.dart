import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hepler/global/global.dart';
import '../providers/functionuser.dart';
import '../providers/user.dart';
import '../services/googlesignin_service.dart';
import 'package:provider/provider.dart';
import '../utils/colors_util.dart';
import '../services/firebase_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final colorBlueShade100 = Colors.blue.shade100;
  var checkValue = true;
  var _editUser = Customer(
    id: 0,
    Name: '',
    Phone: '',
    DateOfBirth: '',
    Email: '',
    Address: '',
    Age: '',
    imagePath: '',
    gender: '',
    Description: '',
    follow: 0,
    rate: 0, isFavorite: false, // Target: '',
    // gender:
  );
  var _initValues = {
    'name': '',
    'phone': '',
    'email': '',
    'password': '',
    'dateofbirth': '',
    'gender': '',
  };

  var _isInit = true;
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Users>(context, listen: false).getDataUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("ffffff"),
              hexStringToColor("ffffff"),
              hexStringToColor("ffffff"),
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
              child: Text(
                'Đăng Nhập',
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFF4c53A5),
                  fontFamily: 'OpenSans',
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                bottom: 60,
                right: 15,
                top: 40,
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/weightlifter.png'),
                radius: 100,
                backgroundColor: Color(0xFF4c53A5),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 38),
                child: ElevatedButton(
                  onPressed: () async {
                    final providers = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    providers.googleLogin();

                    final text = "Login successfully";
                    final snackbar = SnackBar(content: Text(text));

                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  },
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: MaterialStateProperty.resolveWith(
                    //   (states) {
                    //     if (states.contains(MaterialState.pressed)) {
                    //       return Colors.blue;
                    //     }
                    //     return Colors.white;
                    //   },
                    // ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    backgroundColor: Color(0xFF4c53A5),

                    // backgroundColor:
                    //     MaterialStatePropertyAll<Color>(Colors.blue),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 10),
                          child: Image.asset(
                            "assets/images/google.png",
                            height: 48,
                            width: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Sign in with gmail",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: checkValue,
                  onChanged: (bool? value) {
                    setState(() {
                      checkValue = value!;
                    });
                  },
                  checkColor: Color(0xFF4c53A5),
                  activeColor: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    'Tôi đồng ý với Điều kiện và Chính sách quyền riêng tư',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'OpenSans',
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
