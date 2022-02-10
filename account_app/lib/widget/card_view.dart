import 'package:flutter/material.dart';

import '../model/account.dart';
class CardView extends StatelessWidget{

  final HomeAccount _homeAccount;
  CardView(this._homeAccount);


  @override
  Widget build(BuildContext context){
    return
      Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [

            Text('Name : ${_homeAccount.name}'),
            Text('Date : ${_homeAccount.date}'),
            Text('Items : ${_homeAccount.items}'),
            Text('Quantity : ${_homeAccount.quantity}'),
            Text('Rate : ${_homeAccount.rate}'),
            Text('Total : ${_homeAccount.quantity*_homeAccount.rate}'),
            Text('Remark : ${_homeAccount.remark}'),


          ],

        ),
      );
  }
}