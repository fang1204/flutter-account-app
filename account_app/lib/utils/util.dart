import 'dart:developer';
import 'package:account_app/data/home_account_list.dart';
import 'package:account_app/utils/expenses_icons.dart';
import 'package:account_app/utils/shared_preference_util.dart';
import 'package:account_app/widget/items_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/bill_data.dart';
import 'custom_icons.dart';
List typeToList(int t, int typeName){
    String s, p_n;
    var icontype;
    var list0 = ["薪資","打工","獎學金","投資","年終","發票","樂透"];
    var list1 = ["食物","飲料","文具","娛樂","服裝","運動","交通","住宿","3C產品","家俱","保險","醫藥費"];
    var iconList0=[Icons.monetization_on,
                    Icons.account_balance_rounded,
                    Icons.school,
                    Icons.timeline,
                    Icons.money,
                    Icons.receipt_long,
                    CustomIcons.ticket];
    var iconList1=[ExpensesIcons.food,
                    ExpensesIcons.coffee,
                    ExpensesIcons.pencil_ruler,
                    ExpensesIcons.gamepad,
                    ExpensesIcons.t_shirt,
                    ExpensesIcons.basketball_ball,
                    Icons.directions_car_rounded,
                    Icons.home_outlined,
                    Icons.wifi,
                    ExpensesIcons.truck,
                    ExpensesIcons.money_check,
                    ExpensesIcons.briefcase_medical,];
    if (t==0){
      s = list0[typeName];
      p_n = "";
      icontype = iconList0[typeName];
    }
    else{
      s = list1[typeName];
      p_n = "-";
      icontype = iconList1[typeName];
    }
    // _chartData = BillItem();
    // _tooltipBehavior = TooltipBehavior(enable: true);
    // super.initState();
    return [s, p_n,icontype];
}

String formatDate(String itemDate){
  // DateTime.parse(item['date'])
  final DateFormat formatter = DateFormat('yyyy/MM/dd EEEE');
  String  formatted = formatter.format(DateTime.parse(itemDate));


  return formatted;
}

ChangeColor(int choice_IncomePay){
  final Color colorActiveFont = Color.fromARGB(0xff, 246 , 236, 192);
  final Color colorI = Color.fromARGB(0xff, 94, 100, 115);
  final Color colorE = Color.fromARGB(0xff, 255, 159, 151);
  if(choice_IncomePay==0){
    return colorI;
  }
  else{
    return colorE;
  }
}

onChange(String value){
  List notNumberList = ["AC", "ok"];
  if (notNumberList.contains(value)){
    if(value==notNumberList[0]){
      return "0";
    }
    else{
      return "ok";
    }
  }
  else{
    return value;

  }
}