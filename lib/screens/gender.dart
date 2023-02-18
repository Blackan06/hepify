import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import '../screens/age.dart';
import 'package:provider/provider.dart';
import 'thongtincanhan.dart';
import '../providers/functionuser.dart';
import '../providers/user.dart';
import '../utils/colors_util.dart';
import 'package:http/http.dart' as http;

class GenderScreen extends StatefulWidget {
  static const routeName = '/genderScreen';

  @override
  State<GenderScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<GenderScreen> {
  late Future<Customer> futureAlbum;

  final _form = GlobalKey<FormState>();
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
    'dateofbirth': '',
    'address': '',
    'imagepath': '',
    'age': '',
    'gender': '',
    'description': '',
    'rate': '',
    'follow': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Users>(context, listen: false).getDataUser();
    });
  }

  // Future<void> _saveForm() async {
  //   _form.currentState?.save();
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   if (_editUser.id != 0) {
  //     await Provider.of<Users>(context, listen: false)
  //         .updateUser(_editUser.id, _editUser);
  //     print(_editUser.gender);
  //     print(_editUser.id);
  //   } else {
  //     await Provider.of<Users>(context, listen: false).addUser(_editUser);
  //     print(_editUser.gender);
  //     print(_editUser.id);
  //   }
  //   setState(() {
  //     _isLoading = false;
  //   });
  //   Navigator.of(context)
  //       .pushNamed(MuctieuScreen.routeName, arguments: _editUser.id);
  // }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users>(context);
    print(users.itemsUser.length);
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
                bottom: 30,
                right: 15,
                top: 10,
              ),
              child: Text(
                'Giới thiệu ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    letterSpacing: 0.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                bottom: 30,
                right: 15,
                top: 10,
              ),
              child: Text(
                'Để mang đến cho bạn trải nghiệm và kết quả tốt hơn, chúng tôi cần biết giới tính của bạn',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    letterSpacing: 0.5),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: 15,
            //     bottom: 60,
            //     right: 15,
            //     top: 0,
            //   ),
            //   child: CircleAvatar(
            //     radius: 100,
            //     child: Image.asset(
            //       "assets/images/Asset 7.png",
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: 15,
            //     bottom: 60,
            //     right: 15,
            //     top: 0,
            //   ),
            //   child: CircleAvatar(
            //     radius: 100,
            //     child: Image.asset(
            //       "assets/images/Asset 4.png",
            //     ),
            //   ),
            // ),

            Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                alignment: Alignment.center,
                child: Consumer<Users>(
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final todos = value.itemsUser;
                    for (int i = 0; i < todos.length; i++) {
                      if (todos[i].Email !=
                          FirebaseAuth.instance.currentUser!.email) {
                        print(todos[i].gender);
                        todos[i].gender =
                            Gender.Male.toString().substring(7, 11);
                        _editUser = todos[i];
                      } else {
                        todos[i].gender =
                            Gender.Male.toString().substring(7, 11);
                        _editUser = todos[i];
                      }
                    }
                    print(todos.length);
                    return GenderPickerWithImage(
                      maleImage: const AssetImage('assets/images/Asset 7.png'),
                      femaleImage:
                          const AssetImage('assets/images/Asset 4.png'),
                      // to show what's selected on app opens, but by default it's Male
                      selectedGender: Gender.Male,
                      selectedGenderTextStyle: TextStyle(
                          color: Color(0xFF4c53A5),
                          fontWeight: FontWeight.bold),
                      unSelectedGenderTextStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal),
                      onChanged: (Gender? gender) {
                        print(gender);
                      },
                      verticalAlignedText: true,
                      //Alignment between icons
                      equallyAligned: true,

                      animationDuration: Duration(milliseconds: 300),
                      isCircular: true,
                      // default : true,
                      // opacityOfGradient: 0.4,
                      padding: const EdgeInsets.all(3),
                      size: 150, //default : 40
                    );
                  },
                )),
            SizedBox(
              height: 120,
            ),
            SizedBox(
              width: 350,
              child: ElevatedButton(
                onPressed: () async {
                  await Provider.of<Users>(context, listen: false)
                      .addUser(_editUser);

                  Navigator.of(context).pushNamed(UserAddDataScreen.routeName,
                      arguments: _editUser.id);
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
                  'Tiếp Theo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
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

  Future<Customer> fetchAlbum(int id) async {
    final response = await http
        .get(Uri.parse('https://6361d18afabb6460d8ff5276.mockapi.io/user/$id'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Customer.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
