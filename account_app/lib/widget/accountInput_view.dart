import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../common/object_decoration.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../model/bill_data.dart';
import '../utils/shared_preference_util.dart';
/*
Ting編輯
記帳頁面
 */

class AccountInputView extends StatefulWidget{
  const AccountInputView({Key? key}) : super(key: key);

  @override
  _AccountInputViewState createState() => _AccountInputViewState();
}


class _AccountInputViewState extends State<AccountInputView> {
  //日期
  DateTime selectedDate = DateTime.now();
  DateTime ?_dateTime;
  //輸入金錢
  String money='';

  //選擇收入、支出狀態
  int choice_IncomePay = 0;
  //下拉式選單結果
  String ?selectedValue;

  //收入支出
  int ?toggleSwitch_labels;

  bool _selected = false;

  //下拉式選單類別
  //收入
  List incomeDropItems=[
    "薪資",
    "打工",
    "獎學金",
    "投資",
    "年終",
    "發票",
    "樂透",
  ];
  //支出
  List payDropItems = [
    '食物',
    '飲料',
    '文具',
    '娛樂',
    '服裝',
    '運動',
    '交通',
    '住宿',
    '3C產品',
    '家俱',
    '保險',
    '醫藥費',
  ];
  //點選後收入or支出要產生的下拉選單
  List confirm_IncomePay=[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
              //選擇收入和支出
              child:
              ToggleSwitch(
                minWidth: 150.0,
                minHeight: 70.0,
                initialLabelIndex: choice_IncomePay,
                totalSwitches: 2,
                cornerRadius: 30.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                activeBgColors: const[[Colors.blue],[Colors.pink]],
                labels: const["收入","支出"],

                onToggle: (index) {
                  print('switched to: $index');
                  choice_IncomePay = index!;
                  setState(() {
                    print(selectedValue);
                    //切換類別列表
                    toggleSwitch_labels = index;
                    if (index==0) {
                      confirm_IncomePay = incomeDropItems;

                    } else {
                      confirm_IncomePay = payDropItems;
                    }
                  });
                },
              ),
            ),

            //輸入金額
            TextField(
                  decoration: TextFieldDecoration().textInputDecoration('\$\$','請輸入金額'),
                  onChanged: (value) {
                    money = value;
                },
              ),

            //選擇日期
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child:Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                  Text(_dateTime == null ? '尚未選擇日期' : _dateTime.toString().substring(0,11),
                      style: TextStyle(fontSize: 20.sp,color: Colors.blueGrey)),
                  ElevatedButton(
                    child: const Text(
                      '日期選擇',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    onPressed: (){
                      showDatePicker(
                          context: context,
                          initialDate: _dateTime ?? DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2025)
                      ).then((date) {
                        setState(() {
                          _dateTime = date;
                        });
                      });
                    },
                  ),
                ],
              )

            ),

            //下拉選單
            DropdownButton2(
                isExpanded: true,
                hint: Row(
                  children: const [
                    Icon(
                      Icons.list,
                      size: 16,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Text(
                        '選擇類別',
                          style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items:
                confirm_IncomePay.map((item) =>
                    DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )).toList(),

                  onChanged: (value) {
                  setState(() {
                    selectedValue = value as String;
                    print(selectedValue);
                  });
                },
              ),
            Text(selectedValue == null ? '尚未選擇類型' : selectedValue.toString(),style: TextStyle(fontSize: 25.sp),),
            //儲存、取消按鈕
            Container(
              height: 20.h,
              width: 60.w,
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close,color: Colors.red,)
                  ),
                  IconButton(
                      onPressed: (){
                        _save();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.done,color: Colors.green,)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }




  //SharedPreferences存資料
  _save() async {

    /*
    List a = [_dateTime,selectedValue,money,toggleSwitch_labels];
    print(a);
    */
    SharedPreferenceUtil prefs = SharedPreferenceUtil();

    prefs.saveBillData(_dateTime.toString());
    prefs.saveBillData(selectedValue.toString());
    prefs.saveBillData(money.toString());
    prefs.saveBillData(toggleSwitch_labels.toString());

  }
}
