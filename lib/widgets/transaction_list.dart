import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
	final List<Transaction> transactions;
	final Function deleteTransactions;
	TransactionList(this.transactions, this.deleteTransactions);

  @override
  Widget build(BuildContext context) {
	  final mediaQuery = MediaQuery.of(context);
    return transactions.isEmpty ? LayoutBuilder(
      builder: (ctx, constraints){
      	return Column(children: <Widget>[
			    SizedBox(height: 5),
		        Text('No transactions yet!', style: Theme.of(context).textTheme.title,),
			    SizedBox(height: 20),
			    Container(
				    height: constraints.maxHeight*0.6,
				    child: Image.asset(
					    'assets/images/waiting.png',
					    fit: BoxFit.cover,)
			    ),
      ],);}
    )
	    :Container(
	    height: 375,
      child: ListView.builder(
	      itemCount: transactions.length,
	      itemBuilder: (context, index) {
		      return TransactionItem(transactions[index], deleteTransactions);
	      },
    ),);
  }
}
