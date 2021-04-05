import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiranas_business_web/Screens/Login.dart';
import 'package:kiranas_business_web/Screens/Home.dart';
import 'package:kiranas_business_web/Screens/Orders.dart';
import 'package:kiranas_business_web/CustomWidgets/AddProduct.dart';
import 'package:kiranas_business_web/Screens/ProductDetails.dart';
import 'package:kiranas_business_web/Screens/TransactionScreen.dart';
import 'package:kiranas_business_web/Screens/NoAdminScreen.dart';
import 'package:kiranas_business_web/Screens/Maintainance.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    // final args = settings.arguments;

    switch (settings.name) {
      case '/Login':
        return MaterialPageRoute(settings: settings, builder: (_) => Login());
      case '/Home':
        {
          final Home args = settings.arguments;
          MaterialPageRoute<dynamic> pageRoute;

          if (isUserLoggedIn) {
            pageRoute = MaterialPageRoute(
              settings: settings,
              builder: (_) => Home(),
            );
          } else {
            userLoggedOutToast();
            SystemNavigator.routeUpdated(
                routeName: '/Login', previousRouteName: null);
            pageRoute = MaterialPageRoute(builder: (_) => Login());
          }
          return pageRoute;
        }
      // case '/':
      //   final Home args = settings.arguments;

      //   return MaterialPageRoute(
      //     builder: (_) => Home(
      //       phone: args.phone,
      //       user: args.user,
      //       userID: args.userID,
      //     ),
      //   );
      case '/Orders':
        {
          final Orders args = settings.arguments;
          print(args.toString());
          MaterialPageRoute<dynamic> pageRoute;

          if (isUserLoggedIn) {
            pageRoute = MaterialPageRoute(
              settings: settings,
              builder: (_) => Orders(initialTabIndex: "0"),
            );
          } else {
            userLoggedOutToast();
            SystemNavigator.routeUpdated(
                routeName: '/Login', previousRouteName: null);
            pageRoute = MaterialPageRoute(builder: (_) => Login());
          }
          return pageRoute;
        }
      case '/TransactionScreen':
        MaterialPageRoute<dynamic> pageRoute;

        if (isUserLoggedIn) {
          pageRoute = MaterialPageRoute(
            builder: (_) => TransactionScreen(),
          );
        } else {
          userLoggedOutToast();
          SystemNavigator.routeUpdated(
              routeName: '/Login', previousRouteName: null);
          pageRoute = MaterialPageRoute(builder: (_) => Login());
        }
        return pageRoute;

      case '/AddProduct':
        MaterialPageRoute<dynamic> pageRoute;
        final AddProduct args = settings.arguments;

        if (isUserLoggedIn) {
          pageRoute = MaterialPageRoute(
            builder: (_) => AddProduct(
                isUpdateProduct: args.isUpdateProduct,
                prouctDetail: args.prouctDetail),
          );
        } else if (isUserLoggedIn && args == null) {
          pageRoute = _unAuthRoute();
        } else {
          userLoggedOutToast();
          SystemNavigator.routeUpdated(
              routeName: '/Login', previousRouteName: null);
          pageRoute = MaterialPageRoute(builder: (_) => Login());
        }
        return pageRoute;

      case '/NoAdminScreen':
        MaterialPageRoute<dynamic> pageRoute;

        if (isUserLoggedIn) {
          pageRoute = MaterialPageRoute(
            builder: (_) => NoAdminScreen(),
          );
        } else {
          userLoggedOutToast();
          SystemNavigator.routeUpdated(
              routeName: '/Login', previousRouteName: null);
          pageRoute = MaterialPageRoute(builder: (_) => Login());
        }
        return pageRoute;

      case '/Maintainance':
        MaterialPageRoute<dynamic> pageRoute;

        if (isUserLoggedIn) {
          pageRoute = MaterialPageRoute(
            settings: settings,
            builder: (_) => Maintainance(),
          );
        } else {
          userLoggedOutToast();
          SystemNavigator.routeUpdated(
              routeName: '/Login', previousRouteName: null);
          pageRoute = MaterialPageRoute(builder: (_) => Login());
        }
        return pageRoute;
      case '/ProductDetails':
        final ProductDetails args = settings.arguments;

        MaterialPageRoute<dynamic> pageRoute;

        if (isUserLoggedIn && args != null) {
          pageRoute = MaterialPageRoute(
            settings: settings,
            builder: (_) => ProductDetails(
              heroIndex: args.heroIndex,
              productDetailsL: args.productDetailsL,
            ),
          );
        } else if (isUserLoggedIn && args == null) {
          pageRoute = _unAuthRoute();
        } else {
          userLoggedOutToast();
          SystemNavigator.routeUpdated(
              routeName: '/Login', previousRouteName: null);
          pageRoute = MaterialPageRoute(builder: (_) => Login());
        }
        return pageRoute;
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Unknown Route'),
        ),
      );
    });
  }

  static Route<dynamic> _unAuthRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Unautorize'),
        ),
        body: Center(
          child: Text('Unauthorize path, cannot navigate through url'),
        ),
      );
    });
  }
}

userLoggedOutToast() {
  Fluttertoast.showToast(
    gravity: ToastGravity.CENTER,
    msg: "Please login first !",
    fontSize: 20,
    backgroundColor: Colors.black,
  );
}
