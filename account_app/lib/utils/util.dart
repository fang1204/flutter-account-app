
import 'dart:developer';

import 'package:account_app/data/home_account_list.dart';
import 'package:account_app/utils/expenses_icons.dart';
import 'package:account_app/utils/shared_preference_util.dart';
import 'package:account_app/widget/items_view.dart';
import 'package:flutter/material.dart';

import '../model/bill_data.dart';
import 'custom_icons.dart';

List typeToList(int t, int typeName){
    String s, p_n;
    var icontype;
    var list0 = ["薪資","獎學金","投資","年終","發票","樂透","打工"];
    var list1 = ["食物","飲料","文具","娛樂","服裝","運動","交通","住宿","3C產品","家俱","保險","醫藥費"];
    var iconList0=[Icons.monetization_on,
                    Icons.school,
                    Icons.timeline,
                    Icons.money,
                    Icons.receipt_long,
                    CustomIcons.ticket,
                    Icons.account_balance_rounded];
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



