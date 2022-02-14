import 'dart:convert';

import 'package:account_app/home.dart';
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
  //下拉式選單index
  int selectedValue_index=0;
  //收入支出
  int ?toggleSwitch_labels;
  //都有填寫才可送出
  bool isButtonAbled = false;

  List allStatus=[];

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
                minWidth: 60.0.w,
                minHeight: 10.0.h,
                initialLabelIndex: choice_IncomePay,
                totalSwitches: 2,
                cornerRadius: 60.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                activeBgColors: const[[Colors.blue],[Colors.pink]],
                labels: const["收入","支出"],

                onToggle: (index) {
                  print('switched to: $index');
                  choice_IncomePay = index!;
                  setState(() {
                    //(selectedValue);
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
                  keyboardType: TextInputType.number,
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
                        '  選擇類別',
                          style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )).toList(),

                  onChanged: (value) {
                  setState(() {
                    selectedValue = value as String;
                    selectedValue_index = confirm_IncomePay.indexOf(selectedValue);

                    allStatus.add(selectedValue_index);

                    //print(selectedValue);
                    //print(confirm_IncomePay.indexOf(selectedValue));
                  });
                },
              icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
                iconSize: 14.sp,
                iconEnabledColor: Colors.yellow,
                iconDisabledColor: Colors.grey,
                buttonHeight: 10.h,
                buttonWidth: 100.w,
                //buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(
                    color: Colors.black26,
                  ),
                  color: Color.fromARGB(0xFF, 181, 215, 212),
                ),
                buttonElevation: 2,
                itemHeight: 40,
                itemPadding: const EdgeInsets.only(left: 14, right: 14),
                dropdownMaxHeight: 200,
                dropdownWidth: 200,
                dropdownPadding: null,
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Color.fromARGB(0xFF, 181, 215, 212),
                ),
                dropdownElevation: 60,
                scrollbarRadius: const Radius.circular(40),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
                offset: const Offset(-20, 0),
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
                        allStatus=  [];
                        allStatus.add(money);
                        allStatus.add(selectedValue);
                        allStatus.add(_dateTime);
                        allStatus.add(toggleSwitch_labels);

                        CheckDoneAll();

                        if(isButtonAbled){
                          _save();
                          Navigator.pop(context);
                        }
                        else{

                          showAlert(context);

                        }


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

   //確認是否全部都有填寫
   CheckDoneAll(){
     isButtonAbled = true;
    for(int i=0;i<allStatus.length;i++){
        if(allStatus[i]==null){
          isButtonAbled = false;
          return;
        }
    }
  }

  //沒有填寫則跳出警告
  Future<void> showAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('警告'),
          content: const Text('請注意是否全都有選擇'),
          actions: <Widget>[
            TextButton(
              child: Text('確定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //SharedPreferences存資料
  _save() async {

    /*
    List a = [_dateTime,selectedValue,money,toggleSwitch_labels];
    print(a);
    */


    SharedPreferenceUtil prefs = SharedPreferenceUtil();
    //先取得之前儲存資料並解碼加入List，接著再將新資料add進去List，最後在編碼存入

    List total_data = [];

    //存入資料
    BillData perData =
    BillData(
        type: toggleSwitch_labels,
        date: _dateTime.toString(),
        itemType: selectedValue_index,
        quantity:int.parse(money)
    );

    var previousData;
    var previousDataDecode;
    bool firstKeep =false;


    try{
      previousData= await prefs.getBillData();
      previousDataDecode = jsonDecode(previousData);
      //print(previousDataDecode);
    }catch(error){
      firstKeep = true;
      //print(previousDataDecode);
    }


    //如果取得資料為null代表使用者第一次存取

    if (firstKeep == true){
      print("第一次儲存:$firstKeep");

      total_data.add(perData);
      var totalDataEoncode = jsonEncode(total_data);
      prefs.saveBillData(totalDataEoncode);

      print(await prefs.getBillData());

    }

    else{
      print("非第一次儲存:$firstKeep");
      //print(await previousDataDecode);

      for(int i=0;i<previousDataDecode.length;i++){
        total_data.add(previousDataDecode[i]);
      }
      total_data.add(perData);

      var totalDataEoncode = jsonEncode(total_data);
      prefs.saveBillData(totalDataEoncode);
      print(await prefs.getBillData());

    }

    //print(previousDataDecode);
    //total_data.add(previousDataDecode);
    //print(total_data);


/*
    //存入資料
    BillData perData =
    BillData(
        type: toggleSwitch_labels,
        date: _dateTime.toString(),
        itemType: selectedValue_index,
        quantity:int.parse(money)
    );

    previousDataDecode.add(perData);

    var totalDataEoncode = jsonEncode(previousDataDecode);
    //print(totalDataEoncode);


    prefs.saveBillData(totalDataEoncode);
    print(await prefs.getBillData());
*/

  }
}
