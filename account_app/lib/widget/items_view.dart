
import 'package:flutter/material.dart';

import '../model/bill_data.dart';

class BillItem extends StatelessWidget {
  const BillItem({
    required this.bill,
  });

  final BillData bill;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(     //清單中的分類
        height: 40,
        width: 30,
        color: Colors.red,
      ),
      // title: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Expanded(
      //       child: Text(
      //         "${bill.title}",
      //         overflow: TextOverflow.ellipsis,
      //         maxLines: 1,
      //       ),
      //     ),
      //     Text(
      //       "${bill.time}",
      //       style: TextStyle(
      //         fontSize: 12.0,
      //       ),
      //     ),
      //   ],
      // ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              "${bill.itemType}",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Expanded(
            child: Text(
              "${bill.quantity}",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
