import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
	final Function addTx;

	NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
	final titleController = TextEditingController();

	final amountController = TextEditingController();

	DateTime selectedDate;

	void submitData(){
		var enteredTitle = titleController.text;
		var enteredAmount = double.parse(amountController.text);

		if (enteredAmount <= 0 || enteredTitle.isEmpty || selectedDate == null){
			return;
		}
		widget.addTx(
			txTitle: enteredTitle,
			txAmount: enteredAmount,
			txDate: selectedDate,
		);
		Navigator.of(context).pop();
	}

	void popDatePicker(){
		showDatePicker(
			context: context,
			initialDate: DateTime.now(),
			firstDate: DateTime(2020),
			lastDate: DateTime.now(),
		).then((pickedDate) {
				if(pickedDate == null){
					return;
				}
				setState(() {
					selectedDate = pickedDate;
				});
		});
	}

	@override
	Widget build(BuildContext context) {
		return Card(
			elevation: 5,
			child: Container(
				padding: EdgeInsets.only(
					top: 10,
					left: 10,
					right: 10,
					bottom: MediaQuery.of(context).viewInsets.bottom + 10,
				),
				child: SingleChildScrollView(
				  child: Column(
				  	mainAxisAlignment: MainAxisAlignment.spaceAround,
				  	crossAxisAlignment: CrossAxisAlignment.end,
				  	children: <Widget>[
				  		TextField(
				  			decoration: InputDecoration(labelText: 'Title'),
				  			controller: titleController,
				  			onSubmitted: (_) => submitData,
				  		),
				  		TextField(
				  			decoration: InputDecoration(labelText: 'Amount'),
				  			controller: amountController,
				  			keyboardType: TextInputType.number,
				  			onSubmitted: (_) => submitData,
				  		),
				  		Container(
				  			height:50,
				  		  child: Row(
				  			  mainAxisAlignment: MainAxisAlignment.spaceAround,
				  		  	children: <Widget>[
				  		  		Flexible(
				  					  fit: FlexFit.tight,
				  					  child: Text(selectedDate == null ? 'No Date Chosen' : 'Picked Date: ${DateFormat.yMMMd().format(selectedDate)}')),
				  		  		Platform.isIOS ? CupertinoButton(
									    child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold),),
									    onPressed: popDatePicker,
									    color: Theme.of(context).primaryColor,
								    ):
				  		  		FlatButton(
				  		  			child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold),),
				  		  			onPressed: popDatePicker,
				  		  			textColor: Theme.of(context).primaryColor,
				  		  		),
				  		  	],
				  		  ),
				  		),
				  		RaisedButton(
				  			color: Theme.of(context).primaryColor,
				  			child: Text('Add Transaction'),
				  			onPressed: submitData,
				  			textColor: Theme.of(context).textTheme.button.color,),
				  	],
				  ),
				),
			),
		);
	}
}
