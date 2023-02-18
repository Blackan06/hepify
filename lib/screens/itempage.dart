import 'package:carousel_slider/carousel_slider.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/functionuser.dart';
import '../widgets/itemappbar.dart';
import 'cartsrceen.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});
  static const rounteName = '/itempage';

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
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
    final users = Provider.of<Users>(context);
    final cart = Provider.of<Cart>(context, listen: false);

    final userId = ModalRoute.of(context)?.settings.arguments as int;
    var user = users.itemsUser.firstWhere((element) => element.id == userId);
    return Scaffold(
      backgroundColor: Color(0xFFEDECF2),
      body: ListView(
        children: [
          ItemAppBar(),
          Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Card(
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
          ),
          Arc(
            edge: Edge.TOP,
            arcType: ArcType.CONVEY,
            height: 30,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 50,
                      bottom: 20,
                    ),
                    child: Row(children: [
                      Text(
                        user.Name,
                        style: TextStyle(
                          fontSize: 28,
                          color: Color(0xFF4C53A5),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBar.builder(
                          initialRating: user.rate!.toDouble(),
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) async {
                            print(rating);
                            user.rate = rating.toInt();
                            await Provider.of<Users>(context)
                                .updateUser(userId, user);
                          },
                          itemCount: 5,
                          itemSize: 20,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 400,
                    child: Padding(
                      padding: EdgeInsets.only(right: 250),
                      child: Text(
                        user.Description,
                        style: TextStyle(
                          fontSize: 17,
                          color: Color(
                            0xFF4C53A5,
                          ),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$100",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4C53A5),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  cart.addItem(userId, 100.0, user.Name, userId.toString());
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Added item to cart!',
                      ),
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          cart.removeSingleItem(userId.toString());
                        },
                      ),
                    ),
                  );
                  Navigator.of(context)
                      .pushNamed(CartSrceen.routeName, arguments: user.id);
                },
                icon: Icon(
                  CupertinoIcons.cart_badge_plus,
                ),
                label: Text(
                  "Book Now",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color(
                      0xFF4C53A5,
                    ),
                  ),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
                ),
              ),
            ],
          ),
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
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
          ),
        ),
      );
}
