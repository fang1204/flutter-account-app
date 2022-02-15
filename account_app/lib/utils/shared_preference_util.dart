import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil {
  static const String BILLDATA = "billData";

  void saveBillData(String messages) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(BILLDATA, messages);
  }

  Future<String> getBillData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(BILLDATA) ?? "";
  }

  void delBillData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(BILLDATA);
  }
}
