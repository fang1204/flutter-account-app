// import 'dart:convert';
import 'dart:developer';

import 'package:account_app/data/home_account_list.dart';
import 'package:account_app/model/account.dart';
import 'package:account_app/utils/util.dart';
import 'package:account_app/widget/items_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/shared_preference_util.dart';
import 'accountInput_view.dart';
import '../model/bill_data.dart';



class ListItem extends StatefulWidget {

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {


  @override
  Widget build(BuildContext context) {
    return Consumer<HomeAccountList>(
        builder: (context, data, child){
          log("test ${data.totalData}");
          return ListView.builder(
            physics: BouncingScrollPhysics(),     //滾動
            itemCount: data.totalData.length,                     //list長度
            // itemCount: 5,
            shrinkWrap: true,                     //只占據畫面上所需要的大小
            itemBuilder: (context,index){
              log("ListItem ${data.totalData.length}");
              return Dismissible(


                key: UniqueKey(),               //StatefulWidget需要定義給他的
                direction: DismissDirection.horizontal,     //方向
                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    setState(() {
                      data.totalData.removeAt(index);
                    });
                    // showSnakbar(context, 'Mail has beed deleted!');
                  }

                },
                background: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0),
                  color: Colors.blue,
                  child: Icon(Icons.archive_outlined, color: Colors.white),
                ),
                secondaryBackground: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20.0),
                  color: Colors.red,
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                child: BillItem(bill: data.totalData[index]),


              );
              // _cal = cal(BillItem(bill: _totalData[index]));
            },
          );
        }
    );



  }
}



