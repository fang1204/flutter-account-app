//雯坊
import 'dart:convert';
import 'dart:developer';
import 'package:account_app/model/bill_data.dart';
import 'package:account_app/pages/User.dart';
import 'package:account_app/utils/util.dart';
import 'package:account_app/widget/items_view.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
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
    return Consumer<HomeAccountList>(builder: (context, data, child) {
      // log("OutcomeChart chartData  ${data.chartData}");
      return SafeArea(
          child: Scaffold(
        body: SfCircularChart(
          margin:EdgeInsets.fromLTRB(0,2,0,0),
          annotations: <CircularChartAnnotation>[
            CircularChartAnnotation(
                widget: Container(
                    child: Text("結餘 : " + "${data.p_n[0] - data.p_n[1]}",
                        style: TextStyle(
                            color: Color.fromARGB(0xFF, 0, 0, 0),
                            fontSize: 14))))
          ],
          palette: <Color>[
            Color.fromARGB(0xFF, 255, 159, 151),
            Color.fromARGB(0xFF, 193, 221, 250)
          ],
          // title: ChartTitle(text: 'Income and Expenses'),
          legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
              toggleSeriesVisibility: false,
              position: LegendPosition.bottom),
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
    });
  }
}
