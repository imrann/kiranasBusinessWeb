import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiranas_business_web/Screens/Orders.dart';
import 'package:kiranas_business_web/SharedPref/UserDetailsSP.dart';
import 'package:kiranas_business_web/StateManager/HomeDynamicPage.dart';
import 'package:kiranas_business_web/StateManager/OrdersListState.dart';
import 'package:provider/provider.dart';

import 'DrawerTiles.dart';

class DrawerNav extends StatefulWidget {
  @override
  _DrawerNavState createState() => _DrawerNavState();
}

class _DrawerNavState extends State<DrawerNav> {
  int selectedIndex = 0;
  String text = "Home";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        InkWell(
          child: FutureBuilder<dynamic>(
            future: UserDetailsSP().getUserDetails(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                Map<dynamic, dynamic> data = snapshot.data;
                return Card(
                    margin: EdgeInsets.all(0),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 5),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.pink[900],
                                child: Text(
                                  // "IK",
                                  data['userName']
                                      .toString()
                                      .substring(0, 2)
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 40.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                //"+918369275230",
                                data['userPhone'],
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.pink[900],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  //"+918369275230",
                                  data['userName'].toString(),
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.pink[900],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            color: Colors.pink[900],
                            child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "ADMIN",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ));
              } else {
                return Container(
                  height: 20,
                  width: 100,
                  child: Text("Loading.."),
                );
              }
            },
          ),
        ),
        // DrawerTiles(icon: Icon(Icons.payment), title: 'Payent Details'),
        // Divider(thickness: 0.5, endIndent: 5, color: Colors.grey),
        // DrawerTiles(icon: Icon(Icons.people), title: 'About Us'),
        // Divider(thickness: 0.5, endIndent: 5, color: Colors.grey),
        // DrawerTiles(icon: Icon(Icons.contact_phone), title: 'Contact Us'),
        // Divider(thickness: 0.5, endIndent: 5, color: Colors.grey),
        // Container(
        //   child: Text(
        //     "Terms & Policies",
        //     style: TextStyle(fontSize: 13),
        //   ),
        // ),
        // Divider(thickness: 0.5, endIndent: 5, color: Colors.grey),
        // DrawerTiles(icon: Icon(Icons.privacy_tip), title: 'Privacy Policy'),
        // Divider(thickness: 0.5, endIndent: 5, color: Colors.grey),
        // DrawerTiles(icon: Icon(Icons.file_copy), title: 'Terms & Conditions'),
        // Divider(thickness: 0.5, endIndent: 5, color: Colors.grey),
        // DrawerTiles(
        //     icon: Icon(Icons.cancel_schedule_send),
        //     title: 'Cancellation/Refund Policies'),
        // Divider(thickness: 0.5, endIndent: 5, color: Colors.grey),
        MediaQuery.of(context).size.width > 800.0
            ? Container(
                margin: EdgeInsets.only(left: 12.0, right: 12.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        updateTabSelection(0, "Home");
                        var homeDYnamicPageState =
                            Provider.of<HomeDynamicPageState>(context,
                                listen: false);
                        SystemNavigator.routeUpdated(
                            routeName: '/Home', previousRouteName: null);
                        homeDYnamicPageState.setActiveHomePage("home");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          getIconButton(0, "Home", Icons.home),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              "Home",
                              style: TextStyle(
                                fontSize: 16,
                                color: selectedIndex == 0
                                    ? Colors.pink[900]
                                    : Colors.grey[400],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //  Divider(thickness: 0.5, endIndent: 5, color: Colors.grey),
                    InkWell(
                      onTap: () {
                        updateTabSelection(1, "Orders");
                        var homeDYnamicPageState =
                            Provider.of<HomeDynamicPageState>(context,
                                listen: false);
                        SystemNavigator.routeUpdated(
                            routeName: '/Orders', previousRouteName: null);
                        homeDYnamicPageState.setActiveHomePage("orders");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          getIconButton(
                            1,
                            "Orders",
                            Icons.view_list_sharp,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              "Orders",
                              style: TextStyle(
                                fontSize: 16,
                                color: selectedIndex == 1
                                    ? Colors.pink[900]
                                    : Colors.grey[400],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Divider(thickness: 0.5, endIndent: 5, color: Colors.grey),
                    InkWell(
                      onTap: () {
                        updateTabSelection(2, "Transactions");
                        var homeDYnamicPageState =
                            Provider.of<HomeDynamicPageState>(context,
                                listen: false);
                        SystemNavigator.routeUpdated(
                            routeName: '/TransactionScreen',
                            previousRouteName: null);
                        homeDYnamicPageState.setActiveHomePage("transactions");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          getIconButton(
                              2, "Trasactions", Icons.compare_arrows_sharp),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              "Trasactions",
                              style: TextStyle(
                                fontSize: 16,
                                color: selectedIndex == 2
                                    ? Colors.pink[900]
                                    : Colors.grey[400],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ))
            : SizedBox(height: 0),
        MediaQuery.of(context).size.width > 800.0
            ? Divider(thickness: 0.5, endIndent: 5, color: Colors.grey)
            : SizedBox(
                height: 0,
              ),

        DrawerTiles(icon: Icon(Icons.add), title: 'Add Product'),
        DrawerTiles(icon: Icon(Icons.exit_to_app), title: 'Logout'),
        Divider(thickness: 0.5, endIndent: 5, color: Colors.grey),
        SizedBox(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Made with ",
                    style: TextStyle(fontSize: 10),
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 15,
                  ),
                  Text(" by immo", style: TextStyle(fontSize: 10))
                ],
              )
            ],
          ),
        )
      ],
    ));
  }

  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
      text = buttonText;
    });
  }

  Widget getIconButton(int sIndex, String pageName, IconData pageIcon) {
    if (sIndex == 1) {
      return new Stack(
        children: <Widget>[
          IconButton(
            icon: Icon(
              pageIcon,
              //darken the icon if it is selected or else give it a different color
              color:
                  selectedIndex == sIndex ? Colors.pink[900] : Colors.grey[400],
            ),
            onPressed: () {},
          ),
          new Positioned(
            right: 0,
            top: 0,
            child: new Container(
                padding: EdgeInsets.all(0),
                decoration: new BoxDecoration(
                  color: Colors.pink[900],
                  borderRadius: BorderRadius.circular(2),
                ),
                constraints: BoxConstraints(
                  minWidth: 13,
                  minHeight: 10,
                ),
                child:
                    Consumer<OrdersListState>(builder: (context, data, child) {
                  return Text(
                    data.getTotalOrdersLength().toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  );
                })),
          ),
        ],
      );
    } else {
      return IconButton(
        //update the bottom app bar view each time an item is clicked
        onPressed: () {
          updateTabSelection(sIndex, pageName);
          switch (pageName) {
            case "Home":
              {
                updateTabSelection(0, "Home");
              }
              break;

            case "Cart":
              {}
              break;

            default:
              {}
              break;
          }
        },
        iconSize: 27.0,
        icon: new Icon(
          pageIcon,
          //darken the icon if it is selected or else give it a different color
          color: selectedIndex == sIndex ? Colors.pink[900] : Colors.grey[400],
        ),
      );
    }
  }
}
