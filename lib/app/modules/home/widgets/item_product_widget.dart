

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ItemProductWidget extends StatelessWidget {
  final int index;
  final Animation<double> animation;
  final dynamic product;
  final Function onTapUpdate;
  final Function onTapDelete;
  const ItemProductWidget({Key? key,
    required this.index,
    this.product,
    required this.onTapUpdate,
    required this.onTapDelete,
    required this.animation
  }) : super(key: key);

  String moneyFormat(int money) {
    final formatter = NumberFormat.simpleCurrency(decimalDigits: 0, name: '\$');
    return formatter.format(money);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(animation),
      child: Card(
        child: Slidable(
          endActionPane:  ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                // An action can be bigger than the others.
                flex: 1,
                onPressed: (BuildContext context) {
                  onTapUpdate();
                },
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.white,
                icon: Icons.edit,
              ),
              SlidableAction(
                onPressed: (BuildContext context) {
                  onTapDelete();
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
              ),
            ],
          ),
          child: ListTile(
            title: Text(product['name']),
            subtitle: Text(moneyFormat(product['price'])),
            onTap: null,
            trailing: Icon(Icons.money),
          ),
        ),
      ),
    );
  }
}
