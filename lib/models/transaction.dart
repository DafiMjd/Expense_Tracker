import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'transaction.g.dart';

@HiveType(typeId: 3)
class Transaction extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String date;

  @HiveField(2)
  String title;

  @HiveField(3)
  int categoryId;

  @HiveField(4)
  bool isCredit;

  @HiveField(5)
  double amount;

  @HiveField(6)
  String user;

  @HiveField(7)
  final String id2;

  TransactionCategory? category;

  Transaction(
      {required this.id2,
      required this.title,
      required this.date,
      required this.categoryId,
      required this.isCredit,
      required this.amount,
      required this.user});
  
  set setCategory(TransactionCategory cat) {
    category = cat;
  }

  static String getMonth(String date) {
    DateFormat format = DateFormat('M');

    return format.format(DateTime.parse(date));
  }

  
}

// enum Type { debit, credit }
