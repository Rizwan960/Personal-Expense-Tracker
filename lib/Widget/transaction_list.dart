import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function deleteTxt;
  const TransactionList(
      {Key? key, required this.userTransaction, required this.deleteTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: userTransaction.isEmpty
            ? Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset('assets/images/nodata.jpg'),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: FittedBox(
                              child:
                                  Text("Rs.${userTransaction[index].ammount}")),
                        ),
                      ),
                      title: Text(
                        userTransaction[index].title,
                        style: const TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(userTransaction[index].date),
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () => deleteTxt(userTransaction[index].id),
                      ),
                    ),
                  );
                },
                itemCount: userTransaction.length,
              ));
  }
}
