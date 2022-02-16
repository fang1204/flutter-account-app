import 'dart:convert';
import 'dart:developer';

import 'package:account_app/model/bill_data.dart';
import 'package:account_app/utils/util.dart';
import 'package:account_app/widget/items_view.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

import '../data/home_account_list.dart';
class GroupedList extends StatefulWidget {
  @override
  _GroupedListState createState() => _GroupedListState();
}

class _GroupedListState extends State<GroupedList> {



  @override
  Widget build(BuildContext context) {
    return Consumer<HomeAccountList>(
        builder: (context, data, child){

          log("test");

          return GroupedListView<dynamic, String>(

            elements: data.tmp,

            groupBy: (item) => item['date'].split(" ")[0],
            groupSeparatorBuilder: (groupValue) => Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 8,right: 8),
                        child: Text(groupValue, textAlign: TextAlign.start,),
                        // style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red),

                      ),

                      Expanded(child: Divider(color: Colors.red),)
                    ],
                  ))
                ],
              ),
            ),

            itemBuilder: (context, item) {
              return Dismissible(

                key: UniqueKey(),               //StatefulWidget需要定義給他的
                direction: DismissDirection.endToStart,     //方向
                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    data.decreaseQty(item);
                    log("_tmp  ${data.tmp}");
                    // setState(() {
                    //   item.removeAt();
                    // });
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
                child: Card(
                  elevation: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Container(
                    child: ListTile(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      leading: Icon(typeToList(item['type'],item['itemType'])[2]),
                      title: Text(typeToList(item['type'],item['itemType'])[0]),
                      trailing: Text(
                        "\$"+typeToList(item['type'],item['itemType'])[1]+"${item['quantity']}",
                        // maxLines: 2,
                      ),
                    ),
                  ),
                ),
              );


            },
            groupComparator: (group1, group2) => group1.compareTo(group2),
            itemComparator: (item1, item2) =>
                item1['date'].compareTo(item2['date']),
            floatingHeader: false,
            order: GroupedListOrder.ASC,
          );
        }
    );

  }

}