import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hepler/messages/message_screen.dart';
import 'package:hepler/providers/cart.dart';
import 'package:hepler/providers/order.dart';
import 'package:hepler/screens/cartsrceen.dart';
import 'package:hepler/screens/edit_product_screen.dart';
import 'package:hepler/screens/freelancescreen.dart';
import 'package:hepler/screens/homepage.dart';
import 'package:hepler/screens/homepagescreen.dart';
import 'package:hepler/screens/itempage.dart';
import 'package:hepler/screens/order_itemsrceen.dart';
import 'package:hepler/screens/ordersrceen.dart';

import '../providers/functionuser.dart';
import '../providers/user.dart';
import '../screens/age.dart';
import '../screens/editthongtincanhan.dart';
import '../screens/gender.dart';
import '../screens/home.dart';
import '../screens/onboarding2.dart';
import '../screens/onboarding3.dart';
import '../screens/setting_user.dart';
import '../screens/tab_bar.dart';
import '../screens/thongtincanhan.dart';
import '../services/googlesignin_service.dart';
import '../utils/colors_util.dart';
import 'package:provider/provider.dart';
import './screens/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import './screens/loading.dart';
import './screens/onboarding1.dart';

import 'providers/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Stripe.publishableKey =
      'pk_test_51MbqecI8hmOItPrcOrqO3ttbWHL324pQmYYKLUGwPbiMVUYD8mmaz6nKXafMrjBoI2jdeWSKcFvWCPPqDja1MR3Z00bFENFYxD';
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider(
          create: (_) => GoogleSignInProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => Users(),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => FoodToday(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => Exercises(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => Steps(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => LopTaps(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => Clubs(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => Courses(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => PersonTrainers(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => BuoiTaps(),
        // ),
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders(),
          update: (ctx, auth, previousOrders) => previousOrders!
            ..receiveToken(
                auth, previousOrders == null ? [] : previousOrders.orders),
        ),
      ],
      child: MaterialApp(
        title: 'Helper App',
        debugShowCheckedModeBanner: false,
        home: LoadingScreen(),
        routes: {
          LoginScreen.routeName: (ctx) => LoginScreen(),
          OnBoarding1Screen.routeName: (ctx) => OnBoarding1Screen(),
          // AgeScreen.routeName: (ctx) => AgeScreen(),
          UserAddDataScreen.routeName: (ctx) => UserAddDataScreen(),
          OnBoarding2Screen.routeName: (ctx) => OnBoarding2Screen(),
          OnBoarding3Screen.routeName: (ctx) => OnBoarding3Screen(),
          TabBarSrceen.rountName: (ctx) => TabBarSrceen(),
          SettingUserSrceen.rounteName: (ctx) => SettingUserSrceen(),
          EditThongTinCaNhanScreen.routeName: (ctx) =>
              EditThongTinCaNhanScreen(),
          HomePage.routeName: (ctx) => HomePage(),
          HomePageScreen.routeName: (ctx) => HomePageScreen(),
          CartSrceen.routeName: (ctx) => CartSrceen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          OrderItemSrceen.routeName: (ctx) => OrderItemSrceen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
          HomePageScreenHouse.rounteName: (ctx) => HomePageScreenHouse(),
          ItemPage.rounteName: (ctx) => ItemPage(),
          MessageScreen.rounteName: (ctx) => MessageScreen(),
          FreeLance.rounteName: (ctx) => FreeLance(),
        },
      ),
    );
  }
}
