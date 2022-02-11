import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../common/object_decoration.dart';
import 'package:toggle_switch/toggle_switch.dart';
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
  //選擇收入、支出狀態
  var choice_IncomePay = 0;
  //下拉式選單結果
  String? selectedValue;

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
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
              //選擇收入和支出
              child: ToggleSwitch(
                minWidth: 150.0,
                minHeight: 70.0,
                initialLabelIndex: 0,
                totalSwitches: 2,
                cornerRadius: 30.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                activeBgColors: const[[Colors.blue],[Colors.pink]],
                labels: const["收入","支出"],
                onToggle: (index) {
                  choice_IncomePay = index!;
                  //切換類別列表
                  if (index=='0') {
                    confirm_IncomePay = incomeDropItems;
                  } else {
                    confirm_IncomePay = payDropItems;
                  }
                  print('switched to: $index');
                },
              ),
            ),

            //輸入金額
            Expanded(
              flex:1,
                child:TextField(
                  decoration: TextFieldDecoration().textInputDecoration('\$\$','請輸入金額'),
              ),
            ),
            //下拉選單
            Expanded(
              flex: 1,
                child: DropdownButton2(
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
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String;
                      print(selectedValue);
                    });
                  },
                ),
            ),
          ],
        ),
      ),
    );

  }
  /*
  //下拉選單偵測是否選擇
  void _dropDownItemSelected(String valueSelectedByUser) {
    setState(() {
      this._select_type = valueSelectedByUser;
      _selected = true;
    });*/
}
