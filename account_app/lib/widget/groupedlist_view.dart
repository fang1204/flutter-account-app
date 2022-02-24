import 'dart:convert';
import 'dart:developer';
import 'package:account_app/widget/accountInput_view.dart';
import 'package:account_app/widget/edit_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:account_app/model/bill_data.dart';
import 'package:account_app/utils/util.dart';
import 'package:flutter/cupertino.dart';
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


          return GroupedListView<dynamic, String>(

            elements: data.tmp,
            groupBy: (item) => formatDate(item['date']),
            groupSeparatorBuilder: (groupValue) => Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 8,right: 8),
                        child: Text(groupValue, textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),

                      ),
                    ],
                  ))
                ],
              ),
            ),

            //item
            itemBuilder: (context, item) {
              return Slidable(

                key: UniqueKey(),

                child: Card(
                  shape:RoundedRectangleBorder(

                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                      leading: Icon(typeToList(item['type'],item['itemType'])[2]),
                      title: Text(typeToList(item['type'],item['itemType'])[0]),
                      trailing: Text(
                        "\$"+typeToList(item['type'],item['itemType'])[1]+"${item['quantity']}",
                        // maxLines: 2,
                      ),
                      onTap: () {

                      },
                    ),
                  ),
                ),
                startActionPane: ActionPane(
                  // A motion is a widget used to control how the pane animates.
                  motion:  ScrollMotion(),

                  // A pane can dismiss the Slidable.
                  dismissible: DismissiblePane(
                    onDismissed: () {
                      data.decreaseQty(item);
                    },
                  ),

                  // All actions are defined in the children parameter.
                  children: [
                    // A SlidableAction can have an icon and/or a label.
                    SlidableAction(
                      onPressed:(context) {data.decreaseQty(item);},
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),

                // The end action pane is the one at the right or the bottom side.
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      flex: 2,
                      onPressed:(context) {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>
                                EditableListTile(editIndex: data.tmp.indexOf(item),editType:item['type'], editDate:item['date'], editQuantity:item['quantity'], editItemType:item['itemType']))).then((value) {

                        }
                        );
                      },
                      backgroundColor: Colors.amberAccent,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),

                  ],
                ),

              );

            },
            groupComparator: (group1, group2) => group1.compareTo(group2),
            itemComparator: (item1, item2) =>
                item1['date'].compareTo(item2['date']),
            floatingHeader: false,
            order: GroupedListOrder.DESC,
          );
        }
    );

  }







}