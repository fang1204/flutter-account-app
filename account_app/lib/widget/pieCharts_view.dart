//雯坊
import 'dart:convert';
import 'dart:developer';
import 'package:account_app/model/bill_data.dart';
import 'package:account_app/pages/User.dart';
import 'package:account_app/utils/util.dart';
import 'package:account_app/widget/items_view.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../data/home_account_list.dart';
import '../model/pie.dart';
import '../utils/shared_preference_util.dart';



class OutcomeChart extends StatefulWidget {
  @override
  _OutcomeChartState createState() => _OutcomeChartState();
}

class _OutcomeChartState extends State<OutcomeChart> {


  late List<IEData> _chartData = [];
  late TooltipBehavior _tooltipBehavior;
  late int p_sum = 0, n_sum = 0;

  List p_n = [0, 0];
  List<BillData> _totalData = [];

  @override

  void initState(){


    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(_onLayoutDone);

  }
  _onLayoutDone(_)  async {

    _totalData =await HomeAccountList().OutputVar() ;

    log("******$_totalData");
    for(var t in _totalData){
      if (t.type == 0){
        p_sum = p_sum + t.quantity!;
      }
      else  if (t.type == 1){
        n_sum = n_sum + t.quantity!;
      }
    }
    p_n[0] = p_sum;
    p_n[1] = n_sum;

    setState(() {
      _chartData = getChartData();
    });
  }

  @override
  Widget build(BuildContext context) {
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
            tooltipBehavior: _tooltipBehavior,
            series: <CircularSeries>[
              DoughnutSeries<IEData, String>(
                dataSource: _chartData,
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

  List<IEData> getChartData(){
    log("*/*$p_n");
    final List<IEData> chartData = [
      IEData('收入', p_n[0]),
      IEData('支出', p_n[1]),
    ];
    return chartData;
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







