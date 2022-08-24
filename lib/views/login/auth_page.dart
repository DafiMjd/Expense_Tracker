// import 'package:universal_io/io.dart';

import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/services/auth_service.dart';
import 'package:expense_tracker/services/category_service.dart';
import 'package:expense_tracker/services/transaction_service.dart';
import 'package:expense_tracker/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _obscureText = true;
  IconData _iconVisible = Icons.visibility_off;

  Color _backgroundColor = Color.fromARGB(255, 34, 56, 90);
  Color _underlineColor = Color(0xFFCCCCCC);
  Color _buttonColor = Color.fromARGB(255, 29, 99, 204);

  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText == true) {
        _iconVisible = Icons.visibility_off;
      } else {
        _iconVisible = Icons.visibility;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: BlocProvider(
        create: (context) => AuthBloc(
            RepositoryProvider.of<AuthService>(context),
            RepositoryProvider.of<TransactionService>(context),
            RepositoryProvider.of<TransactionCategoryService>(context))
          ..add(RegisterServicesEvent()),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SuccessfulLoginState) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(username: state.username)));
            }
          },
          builder: (context, state) {
            if (state is AuthInitial) {
              return ListView(
                padding: EdgeInsets.fromLTRB(32, 72, 32, 24),
                children: [
                  Center(
                    // child: Image.asset('assets/images/logo_dark.png', height: 120),
                    child: Text(
                      'Expense Tracker',
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  TextField(
                    controller: usernameCtrl,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: _underlineColor),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextField(
                    controller: passwordCtrl,
                    obscureText: _obscureText,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: _underlineColor),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      suffixIcon: IconButton(
                          icon:
                              Icon(_iconVisible, color: Colors.white, size: 20),
                          onPressed: () {
                            _toggleObscureText();
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) => _buttonColor,
                        ),
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        )),
                      ),
                      onPressed: () => BlocProvider.of<AuthBloc>(context).add(
                          LoginEvent(usernameCtrl.text, passwordCtrl.text)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      )),
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // Fluttertoast.showToast(msg: 'Click signup', toastLength: Toast.LENGTH_SHORT);
                      },
                      child: Text('No account yet? Create one',
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                    ),
                  )
                ],
              );
            }
            return Container(child: Text('Dafi Majid F'),);
          },
        ),
      ),
    );
  }
}
