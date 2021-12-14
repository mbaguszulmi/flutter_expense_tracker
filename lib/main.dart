import 'package:flutter/material.dart';

import 'widgets/chart.dart';
import 'widgets/transaction_list.dart';
import 'models/transaction.dart';
import 'widgets/new_transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Flutter Expenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transactions = <Transaction>[];

  _createTransaction(Transaction tx) {
    setState(() {
      _transactions.add(tx);
      Navigator.of(context).pop();
    });
  }

  _showCreateTransaction() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return NewTransaction(
            onCreateTransaction: _createTransaction,
          );
        });
  }

  _deleteTransaction(int index) {
    setState(() {
      _transactions.removeAt(index);
    });
  }

  List<Transaction> get _recentTransactions => _transactions
      .where((tx) =>
          tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: [
        IconButton(
          onPressed: _showCreateTransaction,
          icon: const Icon(Icons.add),
        )
      ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Chart(
            transactions: _recentTransactions,
          ),
          Expanded(
            child: TransactionList(
              transactions: _transactions,
              deleteCallback: _deleteTransaction,
            ),
          ),
        ],
      ),
    );
  }
}
