//雯坊
import 'dart:convert';
import 'dart:developer';
import 'package:account_app/model/bill_data.dart';
import 'package:account_app/pages/User.dart';
import 'package:account_app/utils/util.dart';
import 'package:account_app/widget/items_view.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../data/home_account_list.dart';
import '../model/pie.dart';
import '../utils/shared_preference_util.dart';



class OutcomeChart extends StatefulWidget {
  @override
  _OutcomeChartState createState() => _OutcomeChartState();
}
class _OutcomeChartState extends State<OutcomeChart> {
  @override
  Widget build(BuildContext context) {

    return Consumer<HomeAccountList>(
        builder: (context, data, child){
          log("chartData  ${data.chartData}");
          return SafeArea(
              child: Scaffold(
                body: SfCircularChart(
                  title: ChartTitle(text: 'Income and Expenses'),
                  legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.wrap,
                      //         legendShape: BoxShape.circle,
                      position: LegendPosition.bottom
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CircularSeries>[
                    DoughnutSeries<IEData, String>(
                      dataSource: data.chartData,

                      xValueMapper: (IEData data, _) => data.s,
                      yValueMapper: (IEData data, _) => data.num,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      // enableTooltip: true,
                      // explode: true,
                      // explodeAll: true,
                      // explodeOffset: '10%',
                    )
                  ],

                ),
              ));

        }
    );

  }


}


// Future<List> run() async {
//
//   _totalData =await HomeAccountList().OutputVar() ;
//
//
//
//   for(var t in _totalData){
//     if (t.type == 0){
//       p_sum = p_sum + t.quantity!;
//     }
//     else  if (t.type == 1){
//       n_sum = n_sum + t.quantity!;
//       print(t.quantity);
//     }
//   }
//   p_n[0] = p_sum;
//   p_n[1] = n_sum;
//
//   log("*/*$p_n");
//
//   setState(() {
//
//   });
//   return p_n;
// }







