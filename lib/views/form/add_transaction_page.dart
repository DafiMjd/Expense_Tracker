import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/services/category_service.dart';
import 'package:expense_tracker/services/transaction_service.dart';
import 'package:expense_tracker/utils/custom_colors.dart';
import 'package:expense_tracker/views/form/bloc/add_transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionPage extends StatelessWidget {
  const AddTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleCtrl = TextEditingController();
    var amountCtrl = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text('Expense Tracker')),
      body: BlocProvider(
        create: (context) => AddTransactionBloc(
            RepositoryProvider.of<TransactionCategoryService>(context),
            RepositoryProvider.of<TransactionService>(context))
          ..add(AddTransactionLoadCategoriesEvent()),
        child: BlocConsumer<AddTransactionBloc, AddTransactionState>(
          listener: (context, state) {
            if (state is AddTransactionSaveBtnPressedState) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is AddTransactionCategoriesLoadedState ||
                state is AddTransactionCategoryChangedState) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                margin: EdgeInsets.fromLTRB(30, 100, 30, 100),
                child: Container(
                    margin: EdgeInsets.fromLTRB(24, 0, 24, 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: Text(
                              'ADD TRANSACTION',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w900),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: titleCtrl,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[600]!)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: UNDERLINE_COLOR),
                              ),
                              labelText: 'Title',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              child: DropdownButton<int>(
                                underline: Container(
                                  height: 2,
                                  color: UNDERLINE_COLOR.withOpacity(0.5),
                                ),
                                isExpanded: true,
                                hint: Text("Category"),
                                value: state.categoryPicked,
                                items: state.categories.map((value) {
                                  return DropdownMenuItem<int>(
                                    child: Row(
                                      children: [
                                        Icon(TransactionCategory.getIcon(
                                            value.icon)),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(value.name),
                                      ],
                                    ),
                                    value: value.id,
                                  );
                                }).toList(),
                                onChanged: (int? value) {
                                  // setState(() {
                                  //   _valCredit = value!;
                                  // });
                                  context.read<AddTransactionBloc>().add(
                                      AddTransactionChangeCategoryEvent(
                                          state.categories, value!));
                                },
                              ),
                            ),
                          ),
                          TextField(
                            controller: amountCtrl,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[600]!)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: UNDERLINE_COLOR),
                              ),
                              labelText: 'Amount',
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) => MAIN_COLOR,
                                  ),
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                                ),
                                onPressed: () {
                                  _isEverythingInputted(
                                          titleCtrl.text,
                                          state.categoryPicked,
                                          amountCtrl.text)
                                      ? context.read<AddTransactionBloc>().add(
                                          AddTransactionPressSaveBtnEvent(
                                              titleCtrl.text,
                                              state.categoryPicked!,
                                              amountCtrl.text))
                                      : print('input dong');
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    'SAVE',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  bool _isEverythingInputted(String? title, int? catId, String? amount) {
    if (title == null || catId == null || amount == null) {
      return false;
    }
    return true;
  }
}
