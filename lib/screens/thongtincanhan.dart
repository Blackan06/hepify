import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../screens/setting_user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../screens/editthongtincanhan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global/global.dart';
import '../utils/colors_util.dart';
import 'gender.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;

import '../providers/functionuser.dart';
import '../providers/user.dart';
import '../widgets/error_dialog.dart';
import './tab_bar.dart';

class UserAddDataScreen extends StatefulWidget {
  static const routeName = '/useradddata';
  @override
  State<UserAddDataScreen> createState() => _UserAddDataScreenState();
}

class _UserAddDataScreenState extends State<UserAddDataScreen> {
  final _addFormKey = GlobalKey<FormState>();
  final _nameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _ageFocusNode = FocusNode();
  final _dateofbirthFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final dateFormat = DateFormat("dd-MM-yyyy");
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  String sellerImageUrl = "";
  late List<Customer> listUser;
  late String name;
  late int phone;
  late String id;
  late String age;
  late DateTime dateofbirth;
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
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      var userId = ModalRoute.of(context)?.settings.arguments as int;
      print(userId);
      if (userId != null) {
        _editUser = Provider.of<Users>(context, listen: false).findbyId(userId);
        _initValues = {
          'dateofbirth': _editUser.DateOfBirth.toString(),
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     Provider.of<Users>(context, listen: false).getAllDataUser();
  //   });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameFocusNode.dispose();
    _dateofbirthFocusNode.dispose();
    _phoneFocusNode.dispose();
    _ageFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _addFormKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _addFormKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    formValidation();

    try {
      if (_editUser.id != null) {
        _editUser.Email = FirebaseAuth.instance.currentUser!.email!;
        await Provider.of<Users>(context, listen: false)
            .updateUser(_editUser.id, _editUser);
        print(_editUser.imagePath);
      }
      print(_editUser.id);
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong.'),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pushNamed(UserAddDataScreen.routeName);
              },
            )
          ],
        ),
      );
    }
    // finally {
    //   setState(() {
    //     _isLoading = false;
    //   });
    //   Navigator.of(context).pop();
    // }

    setState(() {
      _isLoading = false;
    });

    final text = "Update ${_editUser.Name} successfully";
    final snackbar = SnackBar(content: Text(text));

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    Navigator.of(context)
        .pushNamed(TabBarSrceen.rountName, arguments: _editUser.id);
    // Navigator.of(context).pop();
    // Navigator.of(context).pop();
  }

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    // getting a directory path for saving

    setState(() {
      imageXFile;
    });
  }

  Future<String> formValidation() async {
    if (imageXFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Please select an image.",
            );
          });
    } else {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      fStorage.Reference reference =
          fStorage.FirebaseStorage.instance.ref().child("User").child(fileName);
      fStorage.UploadTask uploadTask =
          reference.putFile(File(imageXFile!.path));
      fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      await taskSnapshot.ref.getDownloadURL().then((url) {
        sellerImageUrl = url;
      });

      await FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "userAvatarUrl": sellerImageUrl,
        "userName": _nameFocusNode.toString().trim(),
      });
      sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences!.setString("photoUrl", sellerImageUrl);
    }
    print(sellerImageUrl);

    return sellerImageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
          padding: EdgeInsets.all(20),
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
                ),
                child: Text(
                  'Thông tin',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 40,
                      color: Color(0xFF4c53A5),
                      fontFamily: 'OpenSans',
                      letterSpacing: 0.5),
                ),
              ),
              SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    InkWell(
                      onTap: () {
                        _getImage();
                      },
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.20,
                        backgroundColor: Color(0xFF4c53A5),
                        backgroundImage: imageXFile == null
                            ? null
                            : FileImage(File(imageXFile!.path)),
                        child: imageXFile == null
                            ? Icon(
                                Icons.add_photo_alternate,
                                size: MediaQuery.of(context).size.width * 0.20,
                                color: Color(0xFF4c53A5),
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
              _isLoading
                  ? SizedBox(
                      height: 600,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SizedBox(
                      height: 480.0,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Form(
                          key: _addFormKey,
                          child: ListView(
                            children: <Widget>[
                              TextFormField(
                                maxLength: 20,
                                style: TextStyle(color: Color(0xFF4c53A5)),
                                initialValue: _initValues['name'],
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFF4c53A5))),
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      color: Color(0xFF4c53A5),
                                    ),
                                    labelText: 'name',
                                    labelStyle: TextStyle(
                                        color: Color(0xFF4c53A5),
                                        fontSize: 20,
                                        fontFamily: 'OpenSans',
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.bold)),
                                textInputAction: TextInputAction.next,
                                focusNode: _nameFocusNode,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_ageFocusNode);
                                },
                                onChanged: (value) => name = value,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Please provide a value.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _editUser = Customer(
                                    Name: value!,
                                    Phone: _editUser.Phone,
                                    DateOfBirth: _editUser.DateOfBirth,
                                    Address: _editUser.Address,
                                    Email: _editUser.Email,
                                    Age: _editUser.Age,
                                    imagePath: _editUser.imagePath,
                                    gender: _editUser.gender,
                                    Description: _editUser.Description,
                                    follow: _editUser.follow,
                                    rate: _editUser.rate,
                                    isFavorite: _editUser.isFavorite,
                                    id: _editUser.id,
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                              ),
                              TextFormField(
                                maxLength: 200,
                                style: TextStyle(color: Color(0xFF4c53A5)),
                                initialValue: _initValues['description'],
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFF4c53A5))),
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      color: Color(0xFF4c53A5),
                                    ),
                                    labelText: 'Description',
                                    labelStyle: TextStyle(
                                        color: Color(0xFF4c53A5),
                                        fontSize: 20,
                                        fontFamily: 'OpenSans',
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.bold)),
                                textInputAction: TextInputAction.next,
                                focusNode: _descriptionFocusNode,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Please enter a description.';
                                  }
                                  if (value!.length < 10) {
                                    return 'Should be at least 10 characters long.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _editUser = Customer(
                                    Name: _editUser.Name,
                                    Phone: _editUser.Phone,
                                    DateOfBirth: _editUser.DateOfBirth,
                                    Address: _editUser.Address,
                                    Email: _editUser.Email,
                                    Age: _editUser.Age,
                                    imagePath: _editUser.imagePath,
                                    gender: _editUser.gender,
                                    Description: value!,
                                    follow: _editUser.follow,
                                    rate: _editUser.rate,
                                    isFavorite: _editUser.isFavorite,
                                    id: _editUser.id,
                                  );
                                },
                              ),
                              TextFormField(
                                style: TextStyle(color: Color(0xFF4c53A5)),
                                initialValue: _initValues['age'],
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFF4c53A5))),
                                    prefixIcon: Icon(
                                      Icons.phone_outlined,
                                      color: Colors.black,
                                    ),
                                    labelText: 'age',
                                    labelStyle: TextStyle(
                                        color: Color(0xFF4c53A5),
                                        fontSize: 20,
                                        fontFamily: 'OpenSans',
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.bold)),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                focusNode: _ageFocusNode,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_phoneFocusNode);
                                },
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Please enter a age.';
                                  }
                                  if (int.tryParse(value.toString()) == null) {
                                    return 'Please enter a valid number.';
                                  }
                                  if (int.parse(value.toString()) <= 0) {
                                    return 'Please enter a number greater than zero.';
                                  }

                                  return null;
                                },
                                onChanged: (value) => age = value,
                                onSaved: (value) {
                                  _editUser = Customer(
                                    Name: _editUser.Name,
                                    Phone: _editUser.Phone,
                                    DateOfBirth: _editUser.DateOfBirth,
                                    Address: _editUser.Address,
                                    Email: _editUser.Email,
                                    Age: age,
                                    imagePath: _editUser.imagePath,
                                    gender: _editUser.gender,
                                    Description: _editUser.Description,
                                    follow: _editUser.follow,
                                    rate: _editUser.rate,
                                    isFavorite: _editUser.isFavorite,
                                    id: _editUser.id,
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                              ),
                              TextFormField(
                                style: TextStyle(color: Color(0xFF4c53A5)),
                                initialValue: _initValues['phone'],
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFF4c53A5))),
                                    prefixIcon: Icon(
                                      Icons.phone_outlined,
                                      color: Colors.black,
                                    ),
                                    labelText: 'phone',
                                    labelStyle: TextStyle(
                                        color: Color(0xFF4c53A5),
                                        fontSize: 20,
                                        fontFamily: 'OpenSans',
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.bold)),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                focusNode: _phoneFocusNode,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_dateofbirthFocusNode);
                                },
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Please enter a phone.';
                                  }
                                  if (int.tryParse(value.toString()) == null) {
                                    return 'Please enter a valid number.';
                                  }
                                  if (int.parse(value.toString()) <= 0) {
                                    return 'Please enter a number greater than zero.';
                                  }
                                  if (value.toString().length <= 9 ||
                                      value.toString().length > 10) {
                                    return 'Please enter a number correct format';
                                  }
                                  return null;
                                },
                                onChanged: (value) => phone = int.parse(value),
                                onSaved: (value) {
                                  _editUser = Customer(
                                    Name: _editUser.Name,
                                    Phone: value!,
                                    DateOfBirth: _editUser.DateOfBirth,
                                    Address: _editUser.Address,
                                    Email: _editUser.Email,
                                    Age: _editUser.Age,
                                    imagePath: _editUser.imagePath,
                                    gender: _editUser.gender,
                                    Description: _editUser.Description,
                                    follow: _editUser.follow,
                                    isFavorite: _editUser.isFavorite,
                                    rate: _editUser.rate,
                                    id: _editUser.id,
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: DateTimeField(
                                  initialValue: DateTime.now(),
                                  style: TextStyle(color: Color(0xFF4c53A5)),
                                  format: dateFormat,
                                  focusNode: _dateofbirthFocusNode,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      fillColor: Colors.white,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                              color: Color(0xFF4c53A5))),
                                      prefixIcon: Icon(
                                        Icons.cake_outlined,
                                        color: Colors.black,
                                      ),
                                      labelText: 'birthday',
                                      labelStyle: TextStyle(
                                          color: Color(0xFF4c53A5),
                                          fontSize: 20,
                                          fontFamily: 'OpenSans',
                                          letterSpacing: 0.5,
                                          fontWeight: FontWeight.bold)),
                                  textInputAction: TextInputAction.next,
                                  readOnly: true,
                                  keyboardType: TextInputType.number,
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100));
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please enter date.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _editUser = Customer(
                                      Name: _editUser.Name,
                                      Phone: _editUser.Phone,
                                      DateOfBirth: value!.toIso8601String(),
                                      Address: _editUser.Address,
                                      Email: _editUser.Email,
                                      Age: _editUser.Age,
                                      imagePath: _editUser.imagePath,
                                      gender: _editUser.gender,
                                      Description: _editUser.Description,
                                      follow: _editUser.follow,
                                      rate: _editUser.rate,
                                      isFavorite: _editUser.isFavorite,
                                      id: _editUser.id,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: Color(0xFF4c53A5),
                          side: BorderSide(
                            color: Color(0xFF4c53A5),
                            width: 4.0,
                          ),
                        ),
                        child: Text(
                          'Quay lại',
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
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveForm,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: Color(0xFF4c53A5),
                        ),
                        child: Text(
                          'Tiếp Theo',
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
            ],
          ),
        ),
      ),
    );
  }
}
