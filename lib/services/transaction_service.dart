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
    //       id2: 'a',
    //       title: 'Beli Makan',
    //       date: '2022-05-19',
    //       categoryId: 2,
    //       isCredit: true,
    //       amount: 20000,
    //       user: 'user'),
    //   Transaction(
    //       id2: 'ab',
    //       title: 'Beli Bensin',
    //       date: '2022-05-19',
    //       categoryId: 1,
    //       isCredit: true,
    //       amount: 30000,
    //       user: 'user'),
    //   Transaction(
    //       id2: 'ab',
    //       title: 'Gaji',
    //       date: '2022-05-19',
    //       categoryId: 4,
    //       isCredit: false,
    //       amount: 12000000,
    //       user: 'user'),
    //   Transaction(
    //       id2: 'ac',
    //       title: 'Beli 2 Baju',
    //       date: '2022-04-19',
    //       categoryId: 6,
    //       isCredit: true,
    //       amount: 300000,
    //       user: 'user'),
    //   Transaction(
    //       id2: 'ad',
    //       title: 'Nonton Bioskop',
    //       date: '2022-04-19',
    //       categoryId: 5,
    //       isCredit: true,
    //       amount: 70000,
    //       user: 'user'),
    //   Transaction(
    //       id2: 'ae',
    //       title: 'Gaji',
    //       date: '2022-04-19',
    //       categoryId: 4,
    //       isCredit: false,
    //       amount: 12000000,
    //       user: 'user'),
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
