import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({Key? key, this.transactions = const [], this.deleteCallback})
      : super(key: key);
  final List<Transaction> transactions;
  final Function(int index)? deleteCallback;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? const Center(
            child: Text("No Transactions yet!"),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              final tx = transactions[index];

              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tx.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(DateFormat.yMMMd().format(tx.date)),
                            ],
                          ),
                        ),
                        Text(
                          "${tx.isExpense ? '-' : ''}Rp${tx.amount.abs()}",
                          style: TextStyle(
                            color: tx.isExpense
                                ? Colors.red[900]
                                : Colors.green[600],
                          ),
                        ),
                        const SizedBox(width: 4),
                        IconButton(
                          onPressed: () {
                            deleteCallback!(index);
                          },
                          icon: const Icon(Icons.delete),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
