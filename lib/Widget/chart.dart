import 'package:flutter/material.dart';
import 'package:personal_expence/Widget/char_bar.dart';
import 'package:personal_expence/models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  const Chart({Key? key, required this.recentTransaction}) : super(key: key);
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double total = 0.0;
      for (int i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          total += recentTransaction[i].ammount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'ammount': total,
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0, (previousValue, element) {
      return (previousValue + (element['ammount'] as double));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  lable: e['day'] as String,
                  spendingAmount: e['ammount'] as double,
                  ammountPercentage: maxSpending == 0
                      ? 0
                      : (e['ammount'] as double) / maxSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
