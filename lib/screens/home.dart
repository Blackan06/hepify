import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hepler/screens/setting_user.dart';
import 'package:hepler/screens/thongtincanhan.dart';
import 'package:provider/provider.dart';
import '../global/global.dart';
import '../providers/functionuser.dart';
import '../providers/user.dart';
import '../screens/gender.dart';
import '../screens/login.dart';
import '../screens/tab_bar.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homepage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    rate: 0,
    isFavorite: false,
    // Target: '',
    // gender:
  );
  var _initValues = {
    'name': '',
    'phone': '',
    'email': '',
    'password': '',
    'dateofbirth': '',
    'gender': '',
    'imagepath': '',
  };
  late int id;
  var _isInit = true;
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Users>(context, listen: false).getAllDataUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users>(context);
    final todos = users.itemsUser;

    print(users.itemsUser.length);
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            var _user = Provider.of<Users>(context, listen: false)
                .findPersonUsingLoop(firebaseAuth.currentUser!.email!);
            if (todos.length <= 0) {
              return GenderScreen();
            } else {
              if (_user != null) {
                return GenderScreen();
              } else {
                return GenderScreen();
              }
            }
            return GenderScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Some thing went gone'),
            );
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
