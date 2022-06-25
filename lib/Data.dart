import 'dart:convert';

import 'package:assignment/User.dart';
import 'package:http/http.dart' as http;

List<User> users = [];

Future<void> getData() async
{
    String apiLink = 'https://tusharsinha-2908.github.io/Demo_API/Demo_Data.json';
    http.Response responseData = await http.get(Uri.parse(apiLink));
    var data = jsonDecode(responseData.body);
    var userData = data[0]['users'] as List;
    // final userList = List<User>.from(userData.map((item) => User.fromJson(item)));
    // return userList;
    if(users.isEmpty) users = List<User>.from(userData.map((item) => User.fromJson(item)));
    print("User Info Acquired : ${users.isNotEmpty}");
}

