import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({Key? key, this.onCreateTransaction}) : super(key: key);

  final Function(Transaction tx)? onCreateTransaction;

  @override
  State<StatefulWidget> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleInputController = TextEditingController();
  final _amountInputController = TextEditingController();

  int _transactionType = 1;
  DateTime _dateSelect = DateTime.now();

  _selectDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: _dateSelect,
        firstDate: DateTime.now().subtract(const Duration(days: 6)),
        lastDate: DateTime.now());

    setState(() {
      _dateSelect = selectedDate!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 20,
            ),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Title",
              ),
              controller: _titleInputController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 20,
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Amount",
              ),
              controller: _amountInputController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: RadioListTile<int>(
                  title: const Text("Income"),
                  value: 1,
                  groupValue: _transactionType,
                  onChanged: (int? val) {
                    setState(() {
                      _transactionType = val ?? 1;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<int>(
                  title: const Text("Expense"),
                  value: -1,
                  groupValue: _transactionType,
                  onChanged: (int? val) {
                    setState(() {
                      _transactionType = val ?? -1;
                    });
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 20,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(DateFormat.yMMMd().format(_dateSelect)),
                ),
                IconButton(
                  onPressed: _selectDate,
                  icon: const Icon(Icons.date_range),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final tx = Transaction(
                      title: _titleInputController.text,
                      amount:
                          (double.tryParse(_amountInputController.text) ?? 0) *
                              _transactionType,
                      date: _dateSelect,
                    );

                    if (tx.title.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Title is required!"),
                        ),
                      );
                      return;
                    }

                    if (_amountInputController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Amount is required!"),
                        ),
                      );
                      return;
                    }

                    _titleInputController.clear();
                    _amountInputController.clear();

                    widget.onCreateTransaction!(tx);
                  },
                  child: const Text("Add Transaction"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
