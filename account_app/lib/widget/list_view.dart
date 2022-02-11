
import 'package:account_app/widget/items_view.dart';
import 'package:flutter/material.dart';

import '../model/bill_data.dart';

class ListItem extends StatefulWidget {
  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  List<BillData> _bill = fakeData;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),     //滾動
      itemCount: _bill.length,                     //list長度
      shrinkWrap: true,                     //只占據畫面上所需要的大小
      itemBuilder: (context,index){
        return Dismissible(
          key: UniqueKey(),               //StatefulWidget需要定義給他的
          direction: DismissDirection.horizontal,     //方向
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              setState(() {
                _bill.removeAt(index);
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
          child: BillItem(bill: _bill[index]),
        );
      },
    );
  }
}
void showSnakbar(context, String s) {
  final snackBar = SnackBar(
    content: Text('$s'),
    duration: Duration(milliseconds: 500),
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
