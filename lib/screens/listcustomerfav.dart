import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../messages/message_screen.dart';
import '../providers/functionuser.dart';
import '../widgets/listcustomerfavappbar.dart';

class ListCustomerFav extends StatefulWidget {
  const ListCustomerFav({super.key});

  @override
  State<ListCustomerFav> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ListCustomerFav> {
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Users>(context, listen: false).getAllDataUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final customerData = Provider.of<Users>(context);
    final users = customerData.itemsUser;
    return Scaffold(
      body: Column(
        children: [
          ListCustomerFavAppBar(),
          Expanded(
            child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            MessageScreen.rounteName,
                            arguments: users[index].id);
                      },
                      key: ValueKey(users[index].id),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      NetworkImage(users[index].imagePath),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 70,
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              users[index].Name,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}
