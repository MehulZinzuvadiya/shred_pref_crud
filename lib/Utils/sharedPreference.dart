import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefDemo {
  SharedPrefDemo._();

  static final SharedPrefDemo sharedPrefDemo = SharedPrefDemo._();
  List<String> l1 = [];
  List<String> s1 = ['mehul', 'raj'];

  void createpref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String jsonString = jsonEncode(s1);
    await prefs.setString('stringListKey', jsonString);
  }

// Handle the case where the list has not been stored yet

  Future<List<String>> readPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('stringListKey');
    l1 = List<String>.from(jsonDecode(jsonString!));
    print(l1);
    return l1;
  }

  // Future<void> deleteDataFromSharedPreferences(int index) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   if (index >= 0 && index < l1.length) {
  //     l1.removeAt(index);
  //     await prefs.setStringList('stringListKey', s1);
  //   }
  // }
}
