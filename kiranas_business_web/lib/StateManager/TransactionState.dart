import 'package:flutter/material.dart';
import 'package:kiranas_business_web/Podo/Transactions.dart';

class TransactionState extends ChangeNotifier {
  List<Transactions> transactionListState = [];

  List<Transactions> getTransactionListState() => transactionListState;

  setTransactionListState(List<Transactions> transactionListState) {
    this.transactionListState = transactionListState;
    notifyListeners();
  }
}
