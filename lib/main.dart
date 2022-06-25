import 'package:assignment/Data.dart';
import 'package:assignment/User.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'Home_Screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // String path = getApplicationDocumentsDirectory().toString();
  await Hive.initFlutter();
  users.clear();
  Hive.registerAdapter(UserAdaptor());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home_Screen(),
      initialRoute: Home_Screen.id,
      routes: {
        Home_Screen.id : (context) => const Home_Screen(),
      },
    );
  }
}