import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

class Chart extends StatelessWidget {
  const Chart({Key? key, this.transactions = const []}) : super(key: key);

  final List<Transaction> transactions;

  List<Map<String, dynamic>> get groupedTransactions =>
      List.generate(7, (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );

        double totalSpendAmount = 0;
        double totalIncomeAmount = 0;

        for (var tx in transactions) {
          final date = tx.date;
          if (date.day == weekDay.day &&
              date.month == weekDay.month &&
              date.year == weekDay.year) {
            if (tx.amount < 0) {
              totalSpendAmount += tx.amount.abs();
              continue;
            }

            totalIncomeAmount += tx.amount;
          }
        }

        return {
          'day': DateFormat.E().format(weekDay),
          'amountSpend': totalSpendAmount,
          'amountIncome': totalIncomeAmount,
        };
      });

  double get maxAmount => groupedTransactions.fold(0, (previousValue, gTx) {
        double maxVal = gTx['amountSpend'] > previousValue
            ? gTx['amountSpend']
            : previousValue;

        if (maxVal < gTx['amountIncome']) {
          maxVal = gTx['amountIncome'];
        }

        return maxVal;
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactions
                .map((gTx) => Expanded(
                  flex: 1,
                  child: ChartBar(
                        spendAmount: gTx['amountSpend'],
                        incomeAmount: gTx['amountIncome'],
                        day: gTx['day'],
                        maxAmount: maxAmount,
                      ),
                ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
