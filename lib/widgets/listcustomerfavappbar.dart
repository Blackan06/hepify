import 'package:flutter/material.dart';

class ListCustomerFavAppBar extends StatelessWidget {
  const ListCustomerFavAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(25),
      child: Row(children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: SizedBox(
            width: 40,
            child: InkWell(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo8.png'),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 25,
          ),
          child: Text(
            "Chat & Messing",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Color(
                0xFF4C53A5,
              ),
            ),
          ),
        ),
        Spacer(),
        Icon(
          Icons.more_vert,
          size: 30,
        ),
      ]),
    );
  }
}
