import 'dart:convert';

import 'package:account_app/home.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  //預設
  List confirm_IncomePay=[
    "薪資",
    "打工",
    "獎學金",
    "投資",
    "年終",
    "發票",
    "樂透",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
                child:Container(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: ToggleSwitch(
                    initialLabelIndex: choice_IncomePay,
                    totalSwitches: 2,
                    cornerRadius: 30.0,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    activeBgColors: const [[Color.fromRGBO(51, 102, 153, 1)],[Color.fromRGBO(153, 51, 51, 1)]],
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
                        //重新設置下拉選單的select value
                        selectedValue = null;

                      });
                    },
                  ),
                ),

            ),
            Expanded(
              flex: 1,
                child: //輸入金額
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    decoration: TextFieldDecoration().textInputDecoration('\$\$','請輸入金額',choice_IncomePay),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      money = value;
                    },
                  ),
                ),
            ),
            Expanded(
              flex: 1,
                child:
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  padding: const EdgeInsets.all(10),
                  child: //下拉選單
                  DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: const [
                        Icon(Icons.list,
                          size: 16,
                          color: Colors.white,
                        ),
                        Expanded(
                          child: Text(
                            '選擇類別',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    value: selectedValue,
                    items:
                    confirm_IncomePay.map((item) =>
                        DropdownMenuItem<String>(
                          value: item,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              item,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                        selectedValue_index = confirm_IncomePay.indexOf(selectedValue);
                        //print(selectedValue);
                        //print(confirm_IncomePay.indexOf(selectedValue));
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                    iconSize: 20.sp,
                    iconEnabledColor: Colors.white,
                    //buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      color:ChangeColor(choice_IncomePay),
                    ),
                    itemPadding: const EdgeInsets.only(left: 50, right: 50),
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: ChangeColor(choice_IncomePay),
                    ),
                    scrollbarRadius: const Radius.circular(30),
                    scrollbarThickness: 10,

                  ),
                ),

            ),

            /*
            Text(selectedValue == null ? '尚未選擇類型' : selectedValue.toString(),
              style: TextStyle(fontSize: 24.sp,color: ChangeColor(choice_IncomePay)),),*/
            Expanded(
              flex: 1,
                child: //選擇日期
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*
                    Text(_dateTime == null ? '尚未選擇日期' : _dateTime.toString().substring(0,11),
                        style: TextStyle(fontSize: 20.sp,color: ChangeColor(choice_IncomePay))),*/
                    Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary : ChangeColor(choice_IncomePay)),
                        child: Text(
                          _dateTime == null ? '尚未選擇日期' : _dateTime.toString().substring(0,11),
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        onPressed: (){
                          showDatePicker(
                            context: context,
                            initialDate: _dateTime ?? DateTime.now(),
                            firstDate: DateTime(2001),
                            lastDate:  DateTime.now(),
                          ).then((date) {
                            setState(() {
                              _dateTime = date;
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
            ),
            Expanded(
                flex:5,
                child: Container()
            ),
            Expanded(
              flex: 1,
              child: //儲存、取消按鈕
                Container(
                  height: 20.h,
                  width: 60.w,
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
                            allStatus.add(choice_IncomePay);
                            //print(choice_IncomePay);
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
            ),

          ],
        ),
      ),
    );
  }

  //變換顏色
  ChangeColor(int choice_IncomePay){
    if(choice_IncomePay==0){
      return Color.fromRGBO(51, 102, 153, 1);
    }
    else{
      return Color.fromRGBO(153, 51, 51, 1);
    }
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


    SharedPreferenceUtil prefs = SharedPreferenceUtil();

    //要存入的資料
    BillData perData =
    BillData(
        type: choice_IncomePay,
        date: _dateTime.toString(),
        itemType: selectedValue_index,
        quantity:int.parse(money)
    );

    List totalData = [];

    //先前資料
    String previousData = await prefs.getBillData();
    //如果沒取到 代表還沒有存過 轉json存進去並編碼存入
    if(previousData.isEmpty){
      totalData.add(perData.toJson());
      prefs.saveBillData(jsonEncode(totalData));
    }
    //有取到 先解碼再合併目前和現在的
    else{
      totalData = jsonDecode(previousData);
      totalData.add(perData);
      prefs.saveBillData(jsonEncode(totalData));
    }

    print(await prefs.getBillData());

/*
    var previousData;
    var previousDataDecode;
    bool firstKeep =false;*/

  /*
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
      print("第一次儲存:$firstKeep");
      //print(await previousDataDecode);

      for(int i=0;i<previousDataDecode.length;i++){
        total_data.add(previousDataDecode[i]);
      }
      total_data.add(perData);

      var totalDataEoncode = jsonEncode(total_data);
      prefs.saveBillData(totalDataEoncode);
      print(await prefs.getBillData());

    }
    */

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

