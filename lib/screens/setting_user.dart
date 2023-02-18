import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hepler/screens/freelancescreen.dart';
import '../providers/functionuser.dart';
import '../screens/editthongtincanhan.dart';
import '../screens/login.dart';
import '../services/firebase_services.dart';
import 'package:provider/provider.dart';
import '../global/global.dart';
import '../providers/auth.dart';
import '../utils/colors_util.dart';
import '../widgets/settingappbar.dart';

class SettingUserSrceen extends StatefulWidget {
  static const rounteName = '/settinguser';

  @override
  State<SettingUserSrceen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SettingUserSrceen> {
  bool status = false;
  String imagePath =
      sharedPreferences?.getString('photoUrl') ?? 'assets/images/Asset 1 1.png';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      body: Column(
        children: [
          SettingAppBar(),
          SingleChildScrollView(
            child: Container(
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
              child: Column(children: <Widget>[
                SizedBox(
                  height: 150,
                  width: 115,
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      imagePath != null
                          ? InkWell(
                              child: CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.width * 0.20,
                                backgroundImage:
                                    AssetImage('assets/images/Asset 1 1.png'),
                              ),
                            )
                          : InkWell(
                              child: CircleAvatar(
                                  radius:
                                      MediaQuery.of(context).size.width * 0.20,
                                  backgroundImage: NetworkImage(imagePath)),
                            )

                      // Positioned(
                      //   bottom: 0,
                      //   right: -25,
                      //   child: RawMaterialButton(
                      //     onPressed: () {},
                      //     elevation: 2.0,
                      //     fillColor: Color(0xFFF5F6F9),
                      //     child: Icon(
                      //       Icons.camera_alt_outlined,
                      //       color: Colors.black,
                      //     ),
                      //     padding: EdgeInsets.all(15.0),
                      //     shape: CircleBorder(),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                const Divider(
                  height: 20,
                  thickness: 2,
                  indent: 30,
                  endIndent: 30,
                  color: Color(0xFF4c53A5),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.account_box_outlined,
                        color: Color(0xFF4c53A5),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                EditThongTinCaNhanScreen.routeName,
                                arguments: userId);
                          },
                          child: Text(
                            'Chỉnh sửa thông tin cá nhân',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                              letterSpacing: 0.5,
                              color: Colors.black,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.account_box_outlined,
                        color: Color(0xFF4c53A5),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                FreeLance.rounteName,
                                arguments: userId);
                          },
                          child: Text(
                            'Update to Freelance',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                              letterSpacing: 0.5,
                              color: Colors.black,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.notifications_active_outlined,
                        color: Color(0xFF4c53A5),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Thông báo',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                            letterSpacing: 0.5,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      FlutterSwitch(
                          activeColor: Colors.yellow,
                          value: status,
                          onToggle: (value) {
                            setState(() {
                              status = value;
                            });
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.security_outlined,
                        color: Color(0xFF4c53A5),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Bảo mật',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                              letterSpacing: 0.5,
                              color: Colors.black,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.help_outline,
                        color: Color(0xFF4c53A5),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Trợ giúp',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                              letterSpacing: 0.5,
                              color: Colors.black,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.language_outlined,
                        color: Color(0xFF4c53A5),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Ngôn ngữ',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                              letterSpacing: 0.5,
                              color: Colors.black,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.logout_outlined,
                        color: Color(0xFF4c53A5),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                          onPressed: () async {
                            await FirebaseServices().googleSignOut();
                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacementNamed('/');
                          },
                          child: Text(
                            'Đăng xuất',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                              letterSpacing: 0.5,
                              color: Colors.black,
                            ),
                          )),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
