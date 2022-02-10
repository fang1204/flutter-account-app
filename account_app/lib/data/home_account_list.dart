import 'package:account_app/model/account.dart';
import 'package:flutter/cupertino.dart';

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

}
