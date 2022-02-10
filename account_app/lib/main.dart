import 'package:account_app/data/home_account_list.dart';
import 'package:account_app/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'balance.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //在 widget 元件樹中的最上層，使用 provider ，方便傳遞到其他底層頁面
    //MultiProvider，因為一個 APP 很少一個 provider 就夠用，所以直接上 MultiProvider 。
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
            value: HomeAccountList()
        )
      ],
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

