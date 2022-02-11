
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
            flex: 3,
            child: Text(
              typeToString(bill.type!, bill.itemType!),
              maxLines: 2,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "${bill.quantity}",
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

