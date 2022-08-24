import 'package:expense_tracker/models/category.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:expense_tracker/models/transaction.dart';

class TransactionCategoryService {
  late Box<TransactionCategory> _categories;

  Future<void> init() async {
    Hive.registerAdapter(TransactionCategoryAdapter());
    _categories = await Hive.openBox('category');

    await _categories.clear();

    await _categories.addAll([
      TransactionCategory(
          id: 1, name: 'Transportation', icon: 'transport'),
      TransactionCategory(id: 2, name: 'Food & Beverage', icon: 'fnb'),
      TransactionCategory(id: 3, name: 'Bills & Utils', icon: 'bnu'),
      TransactionCategory(id: 4, name: 'Income', icon: 'income'),
      TransactionCategory(
          id: 5, name: 'Entertainment', icon: 'entertainment'),
      TransactionCategory(
          id: 6, name: 'Shopping', icon: 'shopping'),
      TransactionCategory(
          id: 7, name: 'Transfer', icon: 'transfer'),
      TransactionCategory(id: 8, name: 'Other', icon: 'other')
    ]);

    print('finish cat add');
  }

  List<TransactionCategory> getCategories() {
    final categories = _categories.values;

    return categories.toList();
  }

  Future<TransactionCategory> getCategory(int id)  async {
    final category =  _categories.values.where((element) => element.id == id);

    return category.toList().first;
  }
}
