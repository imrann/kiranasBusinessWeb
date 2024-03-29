//import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kiranas_business_web/StateManager/FilterListState.dart';
import 'package:kiranas_business_web/StateManager/HomeDynamicPage.dart';
import 'package:kiranas_business_web/StateManager/MiscellaneousState.dart';
import 'package:kiranas_business_web/StateManager/OrdersListState.dart';
import 'package:kiranas_business_web/StateManager/ProductListState.dart';
import 'package:kiranas_business_web/StateManager/TransactionState.dart';

import 'package:provider/provider.dart';
import 'package:kiranas_business_web/Screens/Home.dart';
import 'package:kiranas_business_web/Screens/Login.dart';
import 'package:kiranas_business_web/Screens/Maintainance.dart';
import 'package:kiranas_business_web/Screens/Splash.dart';
import 'package:kiranas_business_web/CommonScreens/RouterGenerator.dart';

import 'SharedPref/UserDetailsSP.dart';
import 'StateManager/CancelledOrderState.dart';
import 'StateManager/DeliveredOrderState.dart';
import 'StateManager/OpenOrderState.dart';

bool isUserLoggedIn;
Future<void> main() async {
  //setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

  var currentLoggedUser;
  FirebaseAuth auth = FirebaseAuth.instance;

  auth.authStateChanges().listen((User user) {
    if (user == null) {
      print('User is currently signed out!');
      currentLoggedUser = null;
      isUserLoggedIn = false;
    } else {
      print('User is signed in!');
      currentLoggedUser = user;
      isUserLoggedIn = true;
    }
  });

  await Future.delayed(Duration(seconds: 3), () {});

  UserDetailsSP().getUserDetails().then((value) {
    Future.delayed(Duration(seconds: 0), () {
      if (currentLoggedUser != null) {
        currentLoggedUser.getIdToken().then((token) {
          print("default : Home");

          runApp(MyApp("HomePage", value["userName"], value["userPhone"],
              value["userId"]));
        });
      } else {
        runApp(MyApp("LoginPage", value["userName"], value["userPhone"],
            value["userId"]));
      }
    });
  });

  // Future.delayed(Duration(seconds: 4), () {
  //   runApp(MyApp("HomePage", "KhanWebTest", "+918369275230", "testID"));
  // });
  runApp(MyApp("SplashScreen", "No User", "No Number", "No uID"));
}

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};
MaterialColor colorCustom = MaterialColor(0xFFffffff, color);
MaterialColor colorCustom1 = MaterialColor(0xFFf48fb1, color);

class MyApp extends StatelessWidget {
  MyApp(this.redirect, this.userName, this.phone, this.userID);

  final String redirect;
  final String userName;
  final String phone;
  final String userID;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProductListState()),
          ChangeNotifierProvider(create: (context) => OrdersListState()),
          ChangeNotifierProvider(create: (context) => FilterListState()),
          ChangeNotifierProvider(create: (context) => MiscellaneousState()),
          ChangeNotifierProvider(create: (context) => TransactionState()),
          ChangeNotifierProvider(create: (context) => DeliveredOrderState()),
          ChangeNotifierProvider(create: (context) => OpenOrderState()),
          ChangeNotifierProvider(create: (context) => CancelledOrderState()),
          ChangeNotifierProvider(create: (context) => HomeDynamicPageState()),
        ],
        child: MaterialApp(
          onGenerateRoute: RouterGenerator.generateRoute,
          title: 'BrandedBaniyaBusiness',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: colorCustom,
            accentColor: colorCustom1,
          ),
          home: _getStartupScreens(redirect, context),
        ));
  }

  unAuthRouteToast() {
    Fluttertoast.showToast(
      gravity: ToastGravity.CENTER,
      msg: "unauthorize path !",
      fontSize: 20,
      backgroundColor: Colors.black,
    );
  }

  Widget _getStartupScreens(String redirectPage, BuildContext context) {
    if (redirectPage == "LoginPage") {
      return Login();
    } else if (redirectPage == "HomePage") {
      return Home();
    } else if (redirectPage == "SplashScreen") {
      return Splash();
    }

    return Maintainance();
  }
}
