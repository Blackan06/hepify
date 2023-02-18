import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hepler/global/global.dart';
import 'package:hepler/screens/tab_bar.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../providers/order.dart';
import '../widgets/cart_item.dart';
import '../widgets/cartappbar.dart';
import 'package:http/http.dart' as http;

class CartSrceen extends StatefulWidget {
  const CartSrceen({super.key});
  static const routeName = '/cartscreen';

  @override
  State<CartSrceen> createState() => _CartSrceenState();
}

class _CartSrceenState extends State<CartSrceen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      body: ListView(
        children: [
          CartAppBar(),
          // Card(
          //   margin: EdgeInsets.all(15),
          //   child: Padding(
          //     padding: EdgeInsets.all(8),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: <Widget>[
          //         Text(
          //           'Total',
          //           style: TextStyle(fontSize: 20),
          //         ),
          //         Spacer(),
          //         Chip(
          //           label: Text(
          //             '\$${cart.totalAmount.toStringAsFixed(2)}',
          //             style: TextStyle(
          //               color:
          //                   Theme.of(context).primaryTextTheme.headline6!.color,
          //             ),
          //           ),
          //           backgroundColor: Theme.of(context).primaryColor,
          //         ),
          //         OrderButton(cart: cart)
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(height: 10),
          Container(
            height: 700,
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].title,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Price:",
                    style: TextStyle(
                      color: Color(0xFF4C53A5),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\&${cart.totalAmount.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              // Container(
              //   alignment: Alignment.center,
              //   height: 50,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: Color(0xFF4C53A5),
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   child: Text(
              //     "Check Out",
              //     style: TextStyle(
              //       fontSize: 25,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              Container(
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF4C53A5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: OrderButton(
                  cart: cart,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: _isLoading
          ? CircularProgressIndicator()
          : Text(
              'ORDER NOW',
              style: TextStyle(color: Colors.black),
            ),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });

              await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );
              setState(() {
                _isLoading = false;
              });
              widget.cart.clear();
              Navigator.of(context).pushNamed(TabBarSrceen.rountName);
            },
      style: TextButton.styleFrom(foregroundColor: Colors.yellow),
    );
  }
}
