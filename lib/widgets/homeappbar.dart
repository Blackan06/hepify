import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../screens/cartsrceen.dart';
import 'badge.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: InkWell(
                child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo8.png'),
            )),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10,
            ),
            child: Text(
              "HIRE LAB",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4C53A5),
              ),
            ),
          ),
          Spacer(),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch!,
              value: cart.itemCount.toString(),
              color: Colors.orange,
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartSrceen.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
