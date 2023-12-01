import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String lable;
  final double spendingAmount;
  final double ammountPercentage;
  const ChartBar(
      {Key? key,
      required this.lable,
      required this.spendingAmount,
      required this.ammountPercentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
            height: 20, child: FittedBox(child: Text('Rs.$spendingAmount'))),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 90,
          width: 20,
          child: Stack(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10)),
            ),
            FractionallySizedBox(
                heightFactor: ammountPercentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                )),
          ]),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 20,
          child: FittedBox(
            child: Text(lable),
          ),
        ),
      ],
    );
  }
}
