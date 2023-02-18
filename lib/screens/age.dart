// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_material_pickers/flutter_material_pickers.dart';
// import 'package:hepler/screens/thongtincanhan.dart';
// import 'package:numberpicker/numberpicker.dart';
// import 'package:provider/provider.dart';

// import '../providers/functionuser.dart';
// import '../providers/user.dart';
// import '../utils/colors_util.dart';

// class AgeScreen extends StatefulWidget {
//   static const routeName = '/age';

//   @override
//   State<AgeScreen> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<AgeScreen> {
//   int _currentValue = 1900;

//   final _form = GlobalKey<FormState>();
//   var _editUser = Customer(
//     id: '',
//     Name: '',
//     Phone: '',
//     DateOfBirth: '',
//     Email: '',
//     Address: '',
//     Age: 0,
//     imagePath: '',
//     // Target: '',
//     // gender:
//   );
//   var _initValues = {
//     'name': '',
//     'phone': '',
//     'email': '',
//     'password': '',
//     'dateofbirth': '',
//     'age': '',
//   };
//   var _isInit = true;
//   var _isLoading = false;
//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     if (_isInit) {
//       var userId = ModalRoute.of(context)?.settings.arguments as String;
//       print(userId);
//       if (userId != null) {
//         _editUser = Provider.of<Users>(context, listen: false).findbyId(userId);
//         _initValues = {
//           'name': _editUser.Name,
//           'email': _editUser.Email,
//           // 'dateofbirth': _editUser.DateOfBirth.toString(),
//           // 'phone': _editUser.Phone,
//           'address': _editUser.Address,
//           'age': _editUser.Age.toString(),
//         };
//       }
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose

//     super.dispose();
//   }

//   Future<void> _saveForm() async {
//     _form.currentState?.save();
//     setState(() {
//       _isLoading = true;
//     });
//     _editUser.Age = _currentValue;
//     await Provider.of<Users>(context, listen: false)
//         .updateUser(_editUser.id, _editUser);
//     print(_editUser.Age);
//     print(_editUser.id);

//     setState(() {
//       _isLoading = false;
//     });
//     Navigator.of(context)
//         .pushNamed(UserAddDataScreen.routeName, arguments: _editUser.id);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               hexStringToColor('41413f'),
//               hexStringToColor('777777'),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           children: <Widget>[
//             Container(
//               padding: const EdgeInsets.only(
//                   left: 15, bottom: 10, right: 15, top: 50),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                 left: 15,
//                 bottom: 30,
//                 right: 15,
//                 top: 10,
//               ),
//               child: Text(
//                 'Năm sinh',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     fontSize: 40,
//                     color: Colors.white,
//                     fontFamily: 'OpenSans',
//                     letterSpacing: 0.5),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                 left: 15,
//                 bottom: 30,
//                 right: 15,
//                 top: 10,
//               ),
//               // child: Text(
//               //   'Tuổi tính theo năm. Điều này sẽ giúp chúng tôi cá nhân hóa một kế hoạch chương trình tập thể dục phù hợp với bạn.Đừng lo lắng bạn luôn có thể thay đổi nó sau trong phần Cài Đặt',
//               //   textAlign: TextAlign.center,
//               //   style: TextStyle(
//               //     fontSize: 16,
//               //     color: Colors.white,
//               //     fontFamily: 'OpenSans',
//               //     letterSpacing: 0.5,
//               //   ),
//               // ),
//               child: RichText(
//                 textAlign: TextAlign.center,
//                 text: TextSpan(
//                     text:
//                         'Tuổi tính theo năm. Điều này sẽ giúp chúng tôi cá nhân hóa một kế hoạch chương trình tập thể dục phù hợp với bạn.Đừng lo lắng bạn luôn có thể thay đổi nó sau trong phần',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white,
//                       fontFamily: 'OpenSans',
//                       letterSpacing: 0.5,
//                     ),
//                     children: <TextSpan>[
//                       TextSpan(
//                         text: ' Cài Đặt',
//                         style: TextStyle(
//                           color: Colors.yellow[700],
//                           fontSize: 16,
//                           fontFamily: 'OpenSans',
//                           letterSpacing: 0.5,
//                         ),
//                       )
//                     ]),
//               ),
//             ),
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   SizedBox(
//                     height: 300,
//                     width: double.infinity,
//                     child: NumberPicker(
//                       textStyle: TextStyle(color: Colors.grey[400]),
//                       key: _form,
//                       maxValue: 2022,
//                       minValue: 1800,
//                       itemCount: 5,
//                       onChanged: (value) {
//                         setState(() {
//                           _currentValue = value;
//                         });
//                       },
//                       value: _currentValue,
//                       selectedTextStyle: TextStyle(
//                         decoration: TextDecoration.combine([]),
//                         fontSize: 40,
//                         fontFamily: 'OpenSans',
//                         letterSpacing: 0.5,
//                         color: Colors.yellow[700],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             // Center(
//             //   child: ElevatedButton(
//             //     child: const Text('Age'),
//             //     onPressed: () => showMaterialNumberPicker(
//             //       context: context,
//             //       title: 'Pick Your Age',
//             //       maxNumber: 100,
//             //       minNumber: 14,
//             //       selectedNumber: _currentValue,
//             //       onChanged: (value) => setState(() => _currentValue = value),
//             //     ),
//             //   ),
//             // ),
//             SizedBox(
//               height: 40,
//             ),
//             SizedBox(
//               width: 350,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       style: OutlinedButton.styleFrom(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 10.0, vertical: 10.0),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30.0),
//                         ),
//                         backgroundColor: Colors.white,
//                         side: BorderSide(
//                           color: Color.fromARGB(194, 239, 216, 12),
//                           width: 4.0,
//                         ),
//                       ),
//                       child: Text(
//                         'Quay Lại',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontFamily: 'OpenSans',
//                           letterSpacing: 0.5,
//                           fontSize: 24,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 30,
//                   ),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         _editUser.Age = _currentValue;
//                         await Provider.of<Users>(context, listen: false)
//                             .updateUser(_editUser.id, _editUser);
//                         Navigator.of(context).pushNamed(
//                             UserAddDataScreen.routeName,
//                             arguments: _editUser.id);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 10.0, vertical: 10.0),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30.0),
//                         ),
//                         backgroundColor: Colors.yellow,
//                       ),
//                       child: Text(
//                         'Tiếp Theo',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontFamily: 'OpenSans',
//                           letterSpacing: 0.5,
//                           fontSize: 24,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
