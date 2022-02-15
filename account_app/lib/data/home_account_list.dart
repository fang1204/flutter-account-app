import 'dart:convert';
import 'dart:developer';

import 'package:account_app/model/account.dart';
import 'package:account_app/model/bill_data.dart';
import 'package:account_app/utils/util.dart';
import 'package:flutter/cupertino.dart';

import '../utils/shared_preference_util.dart';


class HomeAccountList extends ChangeNotifier{

  List<HomeAccount> _creditAccount = [];
  List<HomeAccount> getCreditCardList(){
    return _creditAccount;
  }
  addCreditAccount(HomeAccount creditAccount){
    _creditAccount.add(creditAccount);
    notifyListeners();
  }
  removeCreditCard(int position){
    _creditAccount.removeAt(position);
    notifyListeners();
  }

  Future<List<BillData>> OutputVar() async {
    SharedPreferenceUtil prefs = SharedPreferenceUtil();
    List<BillData> totalData = [];
    String previousData="";
    // String json = jsonEncode(previousDataDecode);
    previousData = await prefs.getBillData();
    // log("previousData$previousData");
    if (previousData.isNotEmpty){
      List tmp = jsonDecode(previousData);
      totalData = tmp.map((e) => BillData.fromJson(e)).toList();

    }
    // print("************");
    // print(totalData);

    notifyListeners();
    return totalData;


    //如果取得資料為null代表使用者第一次存取

  }





}
