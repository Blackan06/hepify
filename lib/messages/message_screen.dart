import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/functionuser.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});
  static const rounteName = '/message';

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Users>(context, listen: false).getAllDataUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          CircleAvatar(),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                "Active 3m ago",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          )
        ]),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.local_phone,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.videocam,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SafeArea(
                child: Row(
              children: [
                Icon(
                  Icons.mic,
                  color: Color(0xFF4C53A5),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF4C53A5).withOpacity(0.05),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.sentiment_satisfied_alt_outlined,
                          color: Color(0xFF4C53A5).withOpacity(0.64),
                        ),
                        SizedBox(
                          width: 5.5,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Type message",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.attach_file,
                          color: Color(0xFF4C53A5).withOpacity(0.64),
                        ),
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Color(0xFF4C53A5).withOpacity(0.64),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
