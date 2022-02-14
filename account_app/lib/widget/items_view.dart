
import 'package:flutter/material.dart';

import '../model/bill_data.dart';
import '../utils/util.dart';

class BillItem extends StatelessWidget {
  const BillItem({
    required this.bill,
  });

  final BillData bill;


  @override
  Widget build(BuildContext context) {

    return ListTile(

      leading: Container(     //清單中的分類
        height: 30,
        width: 30,
        color: Colors.red,
      ),

      title:  Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              typeToList(bill.type!, bill.itemType!)[0],
              // maxLines: 2,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "\$"+typeToList(bill.type!, bill.itemType!)[1]+"${bill.quantity}",
              // maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

