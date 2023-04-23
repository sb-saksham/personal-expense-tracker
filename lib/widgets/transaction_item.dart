import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
	final Transaction transaction;
	final Function delTransaction;

	TransactionItem(this.transaction, this.delTransaction);

  @override
  Widget build(BuildContext context) {
	  final mediaQuery = MediaQuery.of(context);
    return Card(
	    elevation: 5,
	    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
	    child: ListTile(
		    leading: CircleAvatar(
			    child: Padding(
				    padding: const EdgeInsets.all(6.0),
				    child: FittedBox(
					    child: Text('₹${transaction.amount}')
				    ),
			    ),
			    radius: 30,
		    ),
		    title: Text(
			    transaction.title,
			    style: Theme.of(context).textTheme.title,
		    ),
		    subtitle: Text(DateFormat.yMMMMd().format(transaction.date)),
		    trailing: mediaQuery.size.width > 460 ?
		    FlatButton.icon(
			    textColor: Theme.of(context).errorColor,
			    onPressed: () => delTransaction(transaction.id),
			    icon: Icon(Icons.delete_outline),
			    label: Text('Delete'),
		    )
			    :IconButton(
			    icon: Icon(Icons.delete),
			    color: Theme.of(context).errorColor,
			    onPressed: () => delTransaction(transaction.id),
		    ),
	    ),
    );
  }
}
