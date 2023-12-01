// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import 'package:personal_expence/Widget/new_transaction.dart';
import 'package:personal_expence/Widget/transaction_list.dart';

import 'package:personal_expence/models/transaction.dart';

import 'Widget/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.landscapeRight
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expense Tracker",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        // accentColor: Colors.pink,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _usertransaction = [];

  void _addNewTransaction(String title, double amount, DateTime chossenDate) {
    final newTxt = Transaction(
      id: DateTime.now().toString(),
      title: title,
      ammount: amount,
      date: chossenDate,
    );

    setState(() {
      _usertransaction.add(newTxt);
    });
  }

  List<Transaction> get _recentTransaction {
    return _usertransaction.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addStartNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () => {},
          //behavior: HitTestBehavior.opaque,
          child: NewTransaction(addTransaction: _addNewTransaction),
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _usertransaction.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      backgroundColor: Colors.purple,
      title: const Text("Personal Expence Tracker"),
      actions: <Widget>[
        IconButton(
            onPressed: () => _addStartNewTransaction(context),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 35,
            )),
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,
              child: Chart(recentTransaction: _recentTransaction),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.65,
              child: TransactionList(
                userTransaction: _usertransaction,
                deleteTxt: _deleteTransaction,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _addStartNewTransaction(context),
      ),
    );
  }
}
