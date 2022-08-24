import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 2)
class TransactionCategory extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String icon;

  TransactionCategory(
      {required this.id, required this.name, required this.icon});

  // static getSampleCategory() {
  //   return [
  //     TransactionCategory(id: 1, name: 'Transportation', icon: Icons.emoji_transportation),
  //     TransactionCategory(id: 2, name: 'Food & Beverage', icon: Icons.fastfood),
  //     TransactionCategory(id: 3, name: 'Bills & Utils', icon: Icons.payment),
  //     TransactionCategory(id: 4, name: 'Income', icon: Icons.attach_money),
  //     TransactionCategory(id: 5, name: 'Entertainment', icon: Icons.movie_outlined),
  //     TransactionCategory(id: 6, name: 'Shopping', icon: Icons.shopping_bag_outlined),
  //     TransactionCategory(id: 7, name: 'Transfer', icon: Icons.currency_exchange),
  //     TransactionCategory(id: 8, name: 'Other', icon: Icons.question_mark)
  //   ];
  // }

  static IconData getIcon(String icon) {
    switch (icon) {
      case 'transport':
        {
          return Icons.emoji_transportation;
        }
      case 'fnb':
        {
          return Icons.fastfood;
        }
      case 'bnu':
        {
          return Icons.payment;
        }
      case 'income':
        {
          return Icons.attach_money;
        }
      case 'entertainment':
        {
          return Icons.movie_outlined;
        }
      case 'shopping':
        {
          return Icons.shopping_bag_outlined;
        }
      case 'transfer':
        {
          return Icons.currency_exchange;
        }
      case 'other':
        {
          return Icons.question_mark;
        }
      default:
        {
          return Icons.question_mark;
        }
    }
  }
}

// enum IconEnum {
//   transport,
//   fnb,
//   bnu,
//   income,
//   entertainment,
//   shopping,
//   transfer,
//   other
// }
