import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hepler/screens/editthongtincanhan.dart';
import 'package:hepler/screens/tab_bar.dart';
import 'package:provider/provider.dart';

import '../global/global.dart';
import '../providers/functionuser.dart';
import '../utils/colors_util.dart';

class HomePageScreen extends StatefulWidget {
  static const routeName = '/homepagescreen';

  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final urlImages = [
    'https://itplus-academy.edu.vn/upload/graphic-design.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBkHcsW4ZfJZESHb8itR8262hRYYVifkQNmg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRhXEsO_Uy5O2DJozPW4yHkQ4Lp6kZEjtwMw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbP8hxVs6H_h-3NogbQQ6C6uFh_wpVwpsniQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1E7WhmBwUNFMxhTjfKYUxBNtwLSSXN-fL3g&usqp=CAU',
  ];
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Users>(context, listen: false).getAllDataUser();
    });
  }

  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)?.settings.arguments as int;

    final customer = Provider.of<Users>(context);
    print(customer.itemsUser.length);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.yellow,
                hexStringToColor('FFFFFF'),
                hexStringToColor('FFFFFF'),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  left: 15, bottom: 10, right: 15, top: 50),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                bottom: 60,
                right: 15,
                top: 40,
              ),
              child: Text(
                "Welcome to HireLab",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Recommended",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
                ),
                SizedBox(
                  width: 170,
                ),
                Text(
                  "See All",
                ),
                Icon(
                  Icons.arrow_circle_right,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: CarouselSlider.builder(
                  itemCount: customer.itemsUser.length,
                  options: CarouselOptions(
                    height: 180,
                    autoPlay: true,
                    pageSnapping: false,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    reverse: true,
                    viewportFraction: 1,
                    // autoPlayInterval: Duration(
                    //   seconds: 2,
                    // ),
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = customer.itemsUser[index].imagePath;
                    if (userId == customer.itemsUser[index].id) {
                      index += 1;
                    }
                    return buildImage(urlImage, index);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text(
                  "My Puscharse",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
                ),
                SizedBox(
                  width: 170,
                ),
                Text(
                  "See All",
                ),
                Icon(
                  Icons.arrow_circle_right,
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        margin: EdgeInsets.symmetric(
          horizontal: 12,
        ),
        color: Colors.white,
        width: double.infinity,
        child: InkWell(
          onTap: () {},
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
          ),
        ),
      );
}
