import 'package:expense_tracker/services/auth_service.dart';
import 'package:expense_tracker/services/category_service.dart';
import 'package:expense_tracker/services/transaction_service.dart';
import 'package:expense_tracker/views/form/add_transaction_page.dart';
import 'package:expense_tracker/views/home/home_page.dart';
import 'package:expense_tracker/views/login/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthService()),
        RepositoryProvider(create: (context) => TransactionService()),
        RepositoryProvider(create: (context) => TransactionCategoryService()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        home: HomePage(username: 'user',),
        // home: AddTransactionPage(),
      ),
    );
  }
}
