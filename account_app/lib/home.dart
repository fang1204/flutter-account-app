import 'package:account_app/data/home_account_list.dart';
import 'package:account_app/model/account.dart';
import 'package:account_app/widget/card_view.dart';
import 'package:account_app/widget/pieCharts_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final title = '測試';

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeAccountList>(builder: (context, data, child) {
      return Scaffold(
        appBar: AppBar(
          //最上排
          title: Text('日期調整器'), //調整日期
          backgroundColor: const Color.fromARGB(0xFF, 181, 215, 212),

          /*標題列(清單、和日期)
        leading: IconButton(        //左滑清單

          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(               //+
            icon: Icon(Icons.add_circle),
            onPressed: () {},
          ),
          IconButton(               //右邊三點
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        */
        ),
        drawer: Drawer(
          //清單
          child: ListView(
            children: const <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(0xFF, 181, 215, 212),
                ),
                accountName: Text(
                  //姓名
                  "1",
                ),
                //設定Email
                accountEmail: Text(
                  //mail
                  "****@gmail.com",
                ),
                //設定大頭照
                currentAccountPicture: CircleAvatar(
                  //照片
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      'https://image.freepik.com/free-photo/close-up-portrait-beautiful-cat_23-2149214373.jpg?w=1060'),
                  backgroundColor: Colors.transparent,
                ),
              ),
              ListTile(
                leading: Icon(Icons.equalizer_rounded),
                title: Text('帳務報表'),
              ),
              ListTile(
                leading: Icon(Icons.category_outlined),
                title: Text('分類管理'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('功能設定'),
              ),
            ],
          ),
        ),
        body: Column(
          //主頁面
          children: [
            Expanded(
                //上頁面
                flex: 9,
                child: Row(
                  children: [
                    Expanded(
                      //上左:支出
                      flex: 2,
                      child: Container(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          color: Colors.pink,
                          alignment: Alignment.topCenter,
                          child: Text(
                            '支出',
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                    Expanded(
                      //上中:結餘
                      flex: 7,
                      child: Container(
                          alignment: Alignment.center,
                          child: OutcomeChart(),
                          // child: Text(
                          //   '結餘',
                          //   style: TextStyle(fontSize: 20),
                          // )
                      ),
                    ),
                    Expanded(
                      //上右:收入
                      flex: 2,
                      child: Container(
                          padding: EdgeInsets.only(right: 10, top: 10),
                          color: Colors.pink,
                          alignment: Alignment.topCenter,
                          child: Text(
                            '收入',
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  ],
                )),
            Expanded(
                //中頁面:內縮10要放一個清單在這裡
                flex: 13,
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(                 //主頁面

                    // itemCount: creditAccount.length,
                    itemCount: data.getCreditCardList().length,
                    itemBuilder: (context, position){
                      return CardView(
                          data.getCreditCardList()[position]
                      );
                    },


                  ),
                  // color: Colors.cyanAccent,
                  // child: Text(
                  //   '紀錄list',
                  //   textScaleFactor: 1,
                  //   style: TextStyle(fontSize: 20.0),
                  // ),
                )),
          ],
        ),
        floatingActionButton: FloatingActionButton(     //浮動按鈕
          backgroundColor: Color.fromARGB(0xFF, 250, 175, 165),
          foregroundColor: Colors.white,
          onPressed: () {  },
          child: IconButton(
            onPressed: (){

              HomeAccount _homeAccount = HomeAccount(name: '', date: 'date', items: 'items', quantity: 0, rate: 0, remark: 'remark');

              showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: Text('Add Account'),
                      content: Column(
                        children: [

                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Add Name',
                              labelText: 'Add Name',
                            ),
                            onChanged: (value){
                              _homeAccount.name = value;

                            },
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Add Date',
                              labelText: 'Add Date',
                            ),
                            onChanged: (value){
                              _homeAccount.date = value;

                            },
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Add Item',
                              labelText: 'Add Item',
                            ),
                            onChanged: (value){
                              _homeAccount.items = value;

                            },
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Add Quantity',
                              labelText: 'Add Quantity',
                            ),
                            onChanged: (value){
                              _homeAccount.quantity = int.parse(value);

                            },
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Add Rate',
                              labelText: 'Add Rate',
                            ),
                            onChanged: (value){
                              _homeAccount.rate = int.parse(value);

                            },
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Add Remark',
                              labelText: 'Add Remark',
                            ),
                            onChanged: (value){
                              _homeAccount.remark = value;

                            },
                          ),

                        ],

                      ),
                      actions: [
                        IconButton(
                          color: Colors.green,
                          icon: Icon(Icons.check),
                          onPressed: (){
                            // setState(() {
                            //   creditAccount.add(_creditAccount);
                            // });
                            data.addCreditAccount(_homeAccount);
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          color: Colors.red,
                          icon: Icon(Icons.close),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  });
            },
            icon: Icon(Icons.add),),

        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }
}
