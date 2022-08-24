import 'package:expense_tracker/models/category.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:expense_tracker/models/transaction.dart';

class TransactionService {
  late Box<Transaction> _transactions;

  Future<void> init() async {
    Hive.registerAdapter(TransactionAdapter());
    _transactions = await Hive.openBox('transaction');

    // await _transactions.clear();

    // await _transactions.addAll([
    //   Transaction(
    //       id: 1,
    //       title: 'Belis',
    //       date: '2022-05-19',
    //       categoryId: 1,
    //       isCredit: true,
    //       amount: 700,
    //       user: 'majid'),
    //   Transaction(
    //       id: 1,
    //       title: 'Beli',
    //       date: '2022-04-19',
    //       categoryId: 1,
    //       isCredit: true,
    //       amount: 700,
    //       user: 'dafi'),
    //   Transaction(
    //       id: 1,
    //       title: 'Beli',
    //       date: '2022-03-19',
    //       categoryId: 1,
    //       isCredit: true,
    //       amount: 700,
    //       user: 'majid'),
    //   Transaction(
    //       id: 1,
    //       title: 'Beli',
    //       date: '2022-02-19',
    //       categoryId: 1,
    //       isCredit: true,
    //       amount: 700,
    //       user: 'majid'),
    // ]);

    print('finish transactio nadd');
  }

  List<Transaction> getTransactions(final String username) {
    final transactions =
        _transactions.values.where((element) => element.user == username);

    return transactions.toList();
  }

  void addTransaction(String id, String date, String title, int categoryId,
      bool isCredit, double amount, String user) {
    _transactions.add(Transaction(
        id2: id,
        title: title,
        date: date,
        categoryId: categoryId,
        isCredit: isCredit,
        amount: amount,
        user: user));
  }

  void deleteTransaction(dynamic id, String username) async {
    final transactionToRemove = _transactions.values.firstWhere(
        (element) => element.key == id && element.user == username);
    await transactionToRemove.delete();
  }

  void deleteAllTransaction(String username) async {
    final transactionToRemove = _transactions.values.where(
        (element) => element.user == username);

    final List<dynamic> keys = transactionToRemove.toList().map((e) => e.key).toList();

    _transactions.deleteAll(keys);
  }

  void updateTransaction(String id, String username,
      {int? categoryId, String? title, double? amount, bool? isCredit}) {
    final transactionToEdit = _transactions.values
        .firstWhere((element) => element.id == id && element.user == username);
    final index = transactionToEdit.key as int;
    _transactions.put(
        index,
        Transaction(
            id2: transactionToEdit.id2,
            title: title ?? transactionToEdit.title,
            date: transactionToEdit.date,
            categoryId: categoryId ?? transactionToEdit.categoryId,
            isCredit: isCredit ?? transactionToEdit.isCredit,
            amount: amount ?? transactionToEdit.amount,
            user: transactionToEdit.user));
  }
}
