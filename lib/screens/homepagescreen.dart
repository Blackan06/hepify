import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hepler/screens/itempage.dart';
import '../providers/functionuser.dart';
import 'package:provider/provider.dart';

import '../widgets/homeappbar.dart';
import '../widgets/items_widget.dart';

class HomePageScreenHouse extends StatefulWidget {
  static const rounteName = '/homepagescreenhouse';
  const HomePageScreenHouse({super.key});

  @override
  State<HomePageScreenHouse> createState() => _HomePageScreenHouseState();
}

class _HomePageScreenHouseState extends State<HomePageScreenHouse> {
  final urlImages = [
    'https://itplus-academy.edu.vn/upload/graphic-design.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBkHcsW4ZfJZESHb8itR8262hRYYVifkQNmg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRhXEsO_Uy5O2DJozPW4yHkQ4Lp6kZEjtwMw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbP8hxVs6H_h-3NogbQQ6C6uFh_wpVwpsniQ&usqp=CAU',
  ];
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Users>(context, listen: false).getAllDataUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)?.settings.arguments as int;

    final customer = Provider.of<Users>(context);
    return Scaffold(
      body: ListView(
        children: [
          HomeAppBar(),
          Container(
            // height: 500,
            padding: EdgeInsets.only(
              top: 15,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 50,
                        width: 300,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search here...",
                          ),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.search,
                        size: 27,
                        color: Color(0xFF4C53A5),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: CarouselSlider.builder(
                      itemCount: 4,
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
                        final urlImage = urlImages[index];
                        return buildImage(urlImage, index);
                      },
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                    "Best Rate",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4c53A5),
                    ),
                  ),
                ),
                ItemsWidget(),
              ],
            ),
          ),
        ],
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
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
          ),
        ),
      );
}
