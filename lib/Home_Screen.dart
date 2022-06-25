import 'package:assignment/Constant.dart';
import 'package:assignment/Data.dart';
import 'package:assignment/Display_User.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'User.dart';


class Home_Screen extends StatefulWidget {
  static const String id = 'Home Screen';
  const Home_Screen({Key? key}) : super(key: key);

  @override
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen>{

  //List<User> users = [];
  late Box userBox;
  final _age = TextEditingController();
  String _gender = "Male";

  Future<String> getGender(int index)async
  {
    String gender = "Male";

    await showDialog(
      context: context,
      builder: (context){
        return StatefulBuilder(
            builder: (context, setState){
              return AlertDialog(
                title: const Text('Select Your Gender'),
                content: DropdownButton(
                  value: _gender,
                  hint: const Text('Select Gender'),
                  items: <String>["Male", "Female"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value){
                    setState(() {
                      _gender = value!;
                      gender = _gender;
                    });
                  },
                ),
                actions: [
                  TextButton(
                    child: const Text('Submit'),
                    onPressed: (){
                      // if(users[index].age != -1)
                      // {
                      //   users[index].isSignIn = true;
                      //   (userBox.isEmpty) ? userBox.addAll(users) : userBox.putAt(index, users[index]);
                      //   Navigator.pop(context);
                      //   Navigator.push(context,
                      //       MaterialPageRoute(builder: (context) =>
                      //       Display_User(user: users[index])));
                      // }
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            },
        );
      }
    );

    return gender;
  }

  Future<int> getAge(int index)async
  {
    int value = -1;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Your Age'),
        content: TextField(
          controller: _age,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Age',
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Submit'),
            onPressed: (){
              // int age = int.parse(_age.text);
              // users[index].age = age;
              // Navigator.pop(context);
              // _age.clear();

              value = int.parse(_age.text);
              _age.clear();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );

    return value;

  }


  void fetchData() async
  {
    userBox = await Hive.openBox('Users');

    if(users.isEmpty) await getData();

    print("Users Data Count : ${users.length}");

    if(userBox.isEmpty) {

      if(users.isNotEmpty) {
        userBox.addAll(users);
      }
      else if(users.isEmpty) {
        await getData();
        userBox.clear();
        userBox.addAll(users);
      }

    }

    else {
      users.clear();
      users = List<User>.from(userBox.values.cast().toList());
    }

    setState(() {});

  }


  @override
  void initState() {
    fetchData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Welcome Back!',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.black,
      ),

      body: (users.isNotEmpty) ?
      ListView.builder(
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: const EdgeInsets.only(left: 25,right: 25,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundedButton(
                      text: users[index].name,
                      color: Colors.black,
                      onPress: () async{
                        bool allCheck = false;

                        if(users[index].age > 0 && users[index].gender == "Null")
                        {
                          int age = await getAge(index);
                          String gender = await getGender(index);

                          users[index].age = age;
                          users[index].gender = gender;

                        }

                        if(users[index].age > 0 && users[index].gender == "Null"){

                          String gender = await getGender(index);
                          users[index].gender = gender;

                        }

                        else if(users[index].age < 0 && users[index].gender != "Null"){

                          int age = await getAge(index);
                          users[index].age = age;

                        }

                        if(users[index].age > 0 && users[index].gender != "Null")
                        {
                          allCheck = true;
                        }

                        setState(() {
                          users[index].isSignIn = allCheck;
                        });

                        if(users[index].isSignIn) {

                          // userBox.clear();
                          // userBox.addAll(users);

                          userBox.putAt(index, users[index]);

                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                Display_User(user: users[index])),
                          );

                        }

                       // print(users[index].age);
                       // print(users[index].gender);
                      }

                  ),
                  (users[index].isSignIn == false) ?
                    RoundedButton(
                    color: const Color(0xFF008BDC),
                    text: 'Sign-In',
                    onPress: () async{
                      int age = await getAge(index);
                      String gender = await getGender(index);
                      bool allCheck = false;

                      users[index].age = age;
                      users[index].gender = gender;

                      if(users[index].age > 0 && users[index].gender == "Null"){

                        String gender = await getGender(index);
                        users[index].gender = gender;

                      }

                      else if(users[index].age < 0 && users[index].gender != "Null"){

                        int age = await getAge(index);
                        users[index].age = age;

                      }

                      if(users[index].age > 0 && users[index].gender != "Null")
                      {
                        allCheck = true;
                      }


                      setState(() {
                        users[index].isSignIn = allCheck;
                      });

                      if(users[index].isSignIn) {
                        // userBox.clear();
                        // userBox.addAll(users);
                        userBox.putAt(index, users[index]);

                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              Display_User(user: users[index])),
                        );
                      }

                      },
                    ) :
                    RoundedButton(
                    color: const Color(0xFFFF0000),
                    text: 'Sign-Out',
                    onPress: (){
                      users[index].age = -1;
                      users[index].gender = 'Null';
                      users[index].isSignIn = false;
                      userBox.putAt(index, users[index]);
                      setState(() {});
                    },
                  ),
                ],
              ),
            );
          },
      ) :
      const Center(child: CircularProgressIndicator()),
    );
  }
}
