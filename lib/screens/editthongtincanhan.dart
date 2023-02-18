import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import '../global/global.dart';
import '../screens/setting_user.dart';
import '../screens/tab_bar.dart';
import '../services/storage_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../providers/functionuser.dart';
import '../providers/user.dart';
import '../utils/colors_util.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class EditThongTinCaNhanScreen extends StatefulWidget {
  static const routeName = '/editthongtincanhan';

  @override
  State<EditThongTinCaNhanScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<EditThongTinCaNhanScreen> {
  final _form = GlobalKey<FormState>();
  final _nameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _weightFocusNode = FocusNode();
  final _heightFocusNode = FocusNode();
  final _dateofbirthFocusNode = FocusNode();
  final dateFormat = DateFormat("dd-MM-yyyy");

  XFile? imageXFile;
  var _editUser = Customer(
    id: 0,
    Name: '',
    Phone: '',
    DateOfBirth: '',
    Email: '',
    Age: '',
    Address: '',
    imagePath: '',
    gender: '',
    Description: '',
    follow: 0,
    rate: 0,
    isFavorite: false,
    // Target: '',
  );
  var _initValues = {
    'name': '',
    'phone': '',
    'email': '',
    'address': '',
    'dateofbirth': '',
    'age': '',
    'gender': '',
    'description': '',
    'rate': '',
    'isFavorite': '',
  };
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      final userId = ModalRoute.of(context)?.settings.arguments as int;

      if (userId != null) {
        _editUser = Provider.of<Users>(context, listen: false).findbyId(userId);
        _initValues = {
          'name': _editUser.Name,
          'email': _editUser.Email,
          'dateofbirth': _editUser.DateOfBirth.toString(),
          'phone': _editUser.Phone,
          'address': _editUser.Address.toString(),
          'age': _editUser.Age.toString(),
          'gender': _editUser.gender!,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameFocusNode.dispose();
    _dateofbirthFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Users>(context, listen: false)
          .updateUser(_editUser.id, _editUser);
    } catch (ex) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong.'),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
    final text = "Update ${_editUser.Name} successfully";
    final snackbar = SnackBar(content: Text(text));

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    Navigator.of(context)
        .pushNamed(TabBarSrceen.rountName, arguments: _editUser.id);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  @override
  Widget build(BuildContext context) {
    String imagePath = sharedPreferences?.getString('photoUrl') ??
        'assets/images/Asset 1 1.png';

    var _imageBase64;
    void _getImageBase64() async {
      http.Response imageResponse = await http.get(Uri.parse(imagePath));

      _imageBase64 = base64Encode(imageResponse.bodyBytes);
    }

    return Scaffold(
      appBar: AppBar(
        leading: Image(
          image: AssetImage('assets/images/logo.png'),
        ),
        title: Text(
          'Thông tin cá nhân',
          style: TextStyle(color: Colors.yellow),
        ),
      ),
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
          child: _isLoading
              ? SizedBox(
                  height: 900,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SizedBox(
                  height: 900,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 115,
                        width: 115,
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            imagePath != null
                                ? InkWell(
                                    child: CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.20,
                                      backgroundColor: Colors.white,
                                      backgroundImage: AssetImage(
                                          "assets/images/Asset 1 1.png"),
                                    ),
                                  )
                                : InkWell(
                                    child: CircleAvatar(
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.20,
                                        backgroundColor: Colors.white,
                                        backgroundImage:
                                            NetworkImage(imagePath)),
                                  ),
                          ],
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _editUser.Name,
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'OpenSans',
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4c53A5),
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        height: 20,
                        thickness: 2,
                        indent: 30,
                        endIndent: 30,
                        color: Color(0xFF4c53A5),
                      ),
                      SingleChildScrollView(
                        child: SizedBox(
                          height: 400.0,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Form(
                              key: _form,
                              child: ListView(
                                children: <Widget>[
                                  TextFormField(
                                    style: TextStyle(
                                        color: Color(0xFF4c53A5),
                                        fontFamily: 'OpenSans',
                                        letterSpacing: 0.5),
                                    initialValue: _initValues['email'],
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(
                                        Icons.email_outlined,
                                        color: Color(0xFF4c53A5),
                                      ),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    focusNode: _emailFocusNode,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_nameFocusNode);
                                    },
                                    validator: (value) {
                                      if (value?.isEmpty ?? true) {
                                        return 'Please provide a value.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _editUser = Customer(
                                        Name: _editUser.Name,
                                        Phone: _editUser.Phone,
                                        DateOfBirth: _editUser.DateOfBirth,
                                        Address: _editUser.Address,
                                        Email: value!,
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
                                  TextFormField(
                                    style: TextStyle(
                                        color: Color(0xFF4c53A5),
                                        fontFamily: 'OpenSans',
                                        letterSpacing: 0.5),
                                    initialValue: _initValues['name'],
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(
                                          Icons.person_add_alt_1_outlined,
                                          color: Color(0xFF4c53A5)),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    focusNode: _nameFocusNode,
                                    validator: (value) {
                                      if (value?.isEmpty ?? true) {
                                        return 'Please provide a value.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _editUser = Customer(
                                        Name: value.toString(),
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
                                  DateTimeField(
                                    style: TextStyle(
                                        color: Color(0xFF4c53A5),
                                        fontFamily: 'OpenSans',
                                        letterSpacing: 0.5),
                                    initialValue:
                                        DateTime.parse(_editUser.DateOfBirth),
                                    format: dateFormat,
                                    focusNode: _dateofbirthFocusNode,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.cake_outlined,
                                          color: Color(0xFF4c53A5)),
                                    ),
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
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_phoneFocusNode);
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
                                  TextFormField(
                                    style: TextStyle(
                                        color: Color(0xFF4c53A5),
                                        fontFamily: 'OpenSans',
                                        letterSpacing: 0.5),
                                    initialValue: _initValues['phone'],
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.phone_callback_outlined,
                                          color: Color(0xFF4c53A5)),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    focusNode: _phoneFocusNode,
                                    onFieldSubmitted: (_) {},
                                    validator: (value) {
                                      if (value?.isEmpty ?? true) {
                                        return 'Please enter a phone.';
                                      }
                                      if (int.tryParse(value.toString()) ==
                                          null) {
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
                                        rate: _editUser.rate,
                                        isFavorite: _editUser.isFavorite,
                                        id: _editUser.id,
                                      );
                                    },
                                  ),
                                  // TextFormField(
                                  //   style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontFamily: 'OpenSans',
                                  //       letterSpacing: 0.5),
                                  //   initialValue: _initValues['weight'],
                                  //   decoration: InputDecoration(
                                  //     border: InputBorder.none,
                                  //     icon: Icon(Icons.scale_outlined,
                                  //         color: Colors.white),
                                  //   ),
                                  //   textInputAction: TextInputAction.next,
                                  //   keyboardType: TextInputType.number,
                                  //   focusNode: _phoneFocusNode,
                                  //   validator: (value) {
                                  //     if (value?.isEmpty ?? true) {
                                  //       return 'Please provide a value.';
                                  //     }
                                  //     return null;
                                  //   },
                                  //   onSaved: (value) {
                                  //     _editUser = Customer(
                                  //       Name: _editUser.Name,
                                  //       Phone: _editUser.Phone,
                                  //       DateOfBirth: _editUser.DateOfBirth,
                                  //       Address: _editUser.Address,
                                  //       Email: _editUser.Email,
                                  //       Age: _editUser.Age,
                                  //       id: _editUser.id,
                                  //     );
                                  //   },
                                  // ),
                                  // TextFormField(
                                  //   style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontFamily: 'OpenSans',
                                  //       letterSpacing: 0.5),
                                  //   initialValue: _initValues['height'],
                                  //   decoration: InputDecoration(
                                  //     border: InputBorder.none,
                                  //     icon: Icon(Icons.height_outlined,
                                  //         color: Colors.white),
                                  //   ),
                                  //   textInputAction: TextInputAction.next,
                                  //   keyboardType: TextInputType.number,
                                  //   onFieldSubmitted: (_) {},
                                  //   validator: (value) {
                                  //     if (value?.isEmpty ?? true) {
                                  //       return 'Please provide a value.';
                                  //     }
                                  //     return null;
                                  //   },
                                  //   onSaved: (value) {
                                  //     _editUser = Customer(
                                  //       Name: _editUser.Name,
                                  //       Phone: _editUser.Phone,
                                  //       DateOfBirth: _editUser.DateOfBirth,
                                  //       Address: _editUser.Address,
                                  //       Email: _editUser.Email,
                                  //       Age: _editUser.Age,
                                  //       id: _editUser.id,
                                  //     );
                                  //   },
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 350,
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
                                    width: 2.0,
                                  ),
                                ),
                                child: Text(
                                  'Quay lại',
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
                                  'Update',
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
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
