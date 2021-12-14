import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    Key? key,
    this.spendAmount = 0,
    this.incomeAmount = 0,
    this.day = '',
    this.maxAmount = 0,
  }) : super(key: key);

  final double spendAmount;
  final double incomeAmount;
  final String day;
  final double maxAmount;

  double get spendHeightFactor =>
      maxAmount == 0.0 ? 0.0 : spendAmount / maxAmount;
  double get incomeHeightFactor =>
      maxAmount == 0.0 ? 0.0 : incomeAmount / maxAmount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
          child: FittedBox(
            child: Text("Rp${incomeAmount.toStringAsFixed(0)}"),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 40,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: incomeHeightFactor,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green[600],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(day),
        const SizedBox(height: 4),
        SizedBox(
          height: 40,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendHeightFactor,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red[900],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 20,
          child: FittedBox(
            child: Text("-Rp${spendAmount.toStringAsFixed(0)}"),
          ),
        ),
      ],
    );
  }
}
