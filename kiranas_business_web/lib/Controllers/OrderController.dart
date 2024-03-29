import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:kiranas_business_web/Podo/Orders.dart';
import 'package:kiranas_business_web/Services/OrderService.dart';
import 'package:kiranas_business_web/Services/ProductService.dart';
import 'package:kiranas_business_web/SharedPref/UserDetailsSP.dart';

var now = new DateTime.now();
var formatter = DateFormat("dd-MM-yyyy");
String formattedTodayDate = formatter.format(now);

class OrderController {
  Future<dynamic> getOrdersByType(String type) async {
    Map userDetails = await UserDetailsSP().getUserDetails();

    var ordersList =
        await OrderService().getOrdersByType(type, userDetails['userId']);

    return ordersList;
  }

  Future<dynamic> getOrdersOnlyByType(String type) async {
    var ordersList = await OrderService().getOrdersOnlyByType(type);

    return ordersList;
  }

  Future<dynamic> getTotalOrdersByType(String type) async {
    var ordersLength = await OrderService().getTotalOrdersByType(type);

    return ordersLength;
  }

  Future<dynamic> getPaginatedOrdersOnlyByType(
      String type, String lastOrderID, num lastOUpdateDate) async {
    var ordersList = await OrderService()
        .getPaginatedOrdersOnlyByType(type, lastOrderID, lastOUpdateDate);

    return ordersList;
  }

  Future<dynamic> updateOrderStatus(
      {String orderID, String status, String est}) async {
    var statusResult = await OrderService()
        .updateOrderStatus(orderID: orderID, status: status, est: est);

    return statusResult;
  }

  Future<dynamic> getProductByFilter(
      {String dop,
      String dod,
      String doc,
      String trackingStatus,
      String status}) async {
    var productFilteredSearchList;
    if (dop == null && dod == null && doc == null && trackingStatus == null) {
      print("ALL NULLLLLLLLLLLL");
      productFilteredSearchList =
          await OrderService().getOrdersOnlyByType(status);
    } else {
      productFilteredSearchList = await OrderService().getProductByFilter(
          dop: dop,
          dod: dod,
          doc: doc,
          status: status,
          trackingStatus: trackingStatus);
    }

    return productFilteredSearchList;
  }
}
