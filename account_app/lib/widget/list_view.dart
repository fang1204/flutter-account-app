import 'dart:developer';

import 'package:account_app/utils/util.dart';
import 'package:account_app/widget/items_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/shared_preference_util.dart';
import 'accountInput_view.dart';
import '../model/bill_data.dart';

class ListItem extends StatefulWidget {
  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  List<BillData> _totalData = [];
  // Future<Null> getSharedPrefs() async {
  //   SharedPreferenceUtil prefs = SharedPreferenceUtil();
  //   _totalData = prefs.getBillData();
  //   setState(() {
  //     _controller = new TextEditingController(text: _name);
  //   });
  // }


  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(_onLayoutDone);

  }
  _onLayoutDone(_)  async {
    _totalData = await OutputVar();

    log("$_totalData");
    OutputVar();
    setState(() {
    });
  }



  @override
  Widget build(BuildContext context) {
    // return Column();



    return ListView.builder(
      physics: BouncingScrollPhysics(),     //滾動
      itemCount: _totalData.length,                     //list長度
      // itemCount: 5,
      shrinkWrap: true,                     //只占據畫面上所需要的大小
      itemBuilder: (context,index){

        return Dismissible(


          key: UniqueKey(),               //StatefulWidget需要定義給他的
          direction: DismissDirection.horizontal,     //方向
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              setState(() {
                _totalData.removeAt(index);
              });
              // showSnakbar(context, 'Mail has beed deleted!');
            }
            // else if (direction == DismissDirection.startToEnd) {
            //   showSnakbar(context, 'Mail has beed Archived!');
            // }
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
          child: BillItem(bill: _totalData[index]),

        );

      },
    );


  }
}

