import 'package:flutter/material.dart';
import 'package:kiranas_business_web/CommonScreens/AppBarCommon.dart';
import 'package:kiranas_business_web/CommonScreens/FancyLoader.dart';
import 'package:kiranas_business_web/Controllers/TransactionController.dart';
import 'package:kiranas_business_web/Podo/Transactions.dart';
import 'package:kiranas_business_web/StateManager/TransactionState.dart';
import 'package:provider/provider.dart';
import 'package:kiranas_business_web/CommonScreens/ErrorPage.dart';
import 'package:intl/intl.dart';

final DateFormat formatDate = new DateFormat("EEE, d/M/y");
final DateFormat format = new DateFormat.jms();

Future<dynamic> transactionList;

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    transactionList = TransactionController().getAllTransactions();

    transactionList.then((value) {
      var ordersListState =
          Provider.of<TransactionState>(context, listen: false);
      ordersListState.setTransactionListState(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: new AppBarCommon(
        title: Text(
          "Transactions",
          style: TextStyle(fontSize: 18),
        ),
        //  profileIcon: Icons.search,
        // trailingIcon: Icons.filter_alt_outlined,
        centerTile: false,
        context: context,
        notificationCount: Text("i"),
        isTabBar: false,
        searchOwner: "TransactionSearch",
      ),
      body: Container(
        child: getTransactions(),
      ),
    );
  }

  Widget getTransactions() {
    return FutureBuilder<dynamic>(
      future: transactionList,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          final error = snapshot.error;

          return ErrorPage(error: error.toString());
        } else if (snapshot.hasData) {
          var data = snapshot.data;

          if (data.isEmpty || data.length == 0) {
            return Center(
              child: Text("No Transactions !",
                  style: TextStyle(
                      color: Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 15)),
            );
          } else {
            return Scrollbar(child: Consumer<TransactionState>(
                builder: (context, trasaction, child) {
              List<Transactions> trasactionListState =
                  trasaction.getTransactionListState();

              if (trasactionListState.length > 0) {
                return ListView.builder(
                    //controller: _scrollController,

                    itemCount: trasactionListState.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(3, 10, 3, 0),
                            child: Card(
                              elevation: 1.0,
                              child: ExpansionTile(
                                //tilePadding: EdgeInsets.all(5),

                                title: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 7, 0, 7),
                                  child: Row(
                                    children: [
                                      Text("Debited From: ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                      Text(
                                          trasactionListState[index]
                                              .transData
                                              .tParty,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15))
                                    ],
                                  ),
                                ),
                                subtitle: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "Amount                       " +
                                                    "\u20B9" +
                                                    trasactionListState[index]
                                                        .transData
                                                        .tBillAmt
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              "Status                         ",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12)),
                                          Text(
                                            trasactionListState[index]
                                                .transData
                                                .tStatus
                                                .toString(),
                                            style: TextStyle(
                                                color:
                                                    trasactionListState[index]
                                                                .transData
                                                                .tStatus
                                                                .toString() ==
                                                            "Completed"
                                                        ? Colors.green
                                                        : Colors.red,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 5),
                                        child: Row(
                                          children: [
                                            Text(
                                                "Last Update Date      " +
                                                    "${formatDate.format(new DateTime.fromMillisecondsSinceEpoch(trasactionListState[index].transData.tUpdationDate))}" +
                                                    "  " +
                                                    "${format.format(new DateTime.fromMillisecondsSinceEpoch(trasactionListState[index].transData.tUpdationDate))}",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                children: <Widget>[
                                  Container(
                                      //   height: 100,
                                      color: Colors.grey[100],
                                      child: inventoryCard1(
                                          trasactionListState[index])),
                                ],
                              ),
                            ),
                          ),
                          // Divider(
                          //   thickness: 0,
                          //   indent: 0,
                          //   endIndent: 0,
                          // )
                        ],
                      );
                    });
              } else {
                return Center(
                  child: Text("No Open Orders!!"),
                );
              }
            }));
          }
        } else {
          return FancyLoader(
            loaderType: "list",
          );
        }
      },
    );
  }

  Widget inventoryCard1(Transactions trasactionState) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 10, 15),
      child: Column(
        children: [
          Row(
            children: [
              Text("Trasaction Details:",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 12))
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(thickness: 0.5, endIndent: 5, color: Colors.grey[300]),
          inventoryCardDetails("Order ID", trasactionState.transData.tOrderID),
          Divider(thickness: 0.5, endIndent: 5, color: Colors.grey[300]),
          inventoryCardDetails("Creation Date",
              trasactionState.transData.tCreationDate.toString()),
          Divider(thickness: 0.5, endIndent: 5, color: Colors.grey[300]),
          inventoryCardDetails(
              "Mode Of trasaction", trasactionState.transData.tMode),
          Divider(thickness: 0.5, endIndent: 5, color: Colors.grey[300]),
        ],
      ),
    );
  }

  Widget inventoryCardDetails(String titleName, String titleValue) {
    return Column(
      children: [
        Row(
          children: [
            Text(titleName + ":",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 12)),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            titleName == "Creation Date"
                ? Flexible(
                    child: SelectableText(
                        "${formatDate.format(new DateTime.fromMillisecondsSinceEpoch(int.parse(titleValue)))}" +
                            "  " +
                            "${format.format(new DateTime.fromMillisecondsSinceEpoch(int.parse(titleValue)))}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 12)),
                  )
                : Flexible(
                    child: SelectableText(titleValue,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 12)),
                  )
          ],
        ),
      ],
    );
  }
}
