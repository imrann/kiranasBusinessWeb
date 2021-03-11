import 'package:kiranas_business_web/Services/TransactionService.dart';

class TransactionController {
  Future<dynamic> getAllTransactions() async {
    var transactionList = await TransactionService().getAllTransactions();

    return transactionList;
  }
}
