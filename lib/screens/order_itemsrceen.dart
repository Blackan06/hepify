import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/functionuser.dart';
import '../utils/colors_util.dart';

class OrderItemSrceen extends StatefulWidget {
  const OrderItemSrceen({super.key});
  static const routeName = '/orderScreen';
  @override
  State<OrderItemSrceen> createState() => _OrderItemSrceenState();
}

class _OrderItemSrceenState extends State<OrderItemSrceen> {
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

    final userId = ModalRoute.of(context)?.settings.arguments as int;
    var user = users.itemsUser.firstWhere((element) => element.id == userId);
    return Scaffold(
      appBar: AppBar(
        leading: Image(
          image: AssetImage('assets/images/logo.png'),
        ),
        title: Text(
          'Cart',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                hexStringToColor('FFFFFF'),
                hexStringToColor('FFFFFF'),
                hexStringToColor('FFFFFF'),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(children: <Widget>[
            Text(
              "Your Cart",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              child: Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 5, color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  height: 200,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          user.Name,
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'OpenSans',
                            letterSpacing: 0.5,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          user.Name,
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'OpenSans',
                            letterSpacing: 0.5,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
