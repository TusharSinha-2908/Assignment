import 'package:flutter/material.dart';

import 'User.dart';

class Display_User extends StatelessWidget {
  static const String id = 'Display User';
  User user;

  Display_User({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'User Details',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "Name : ${user.name}",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white
                ),
            ),
            const SizedBox(height: 10),
            Text("Age : ${user.age}",
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
            ),
            const SizedBox(height: 10),
            Text("Gender : ${user.gender}",
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
            ),
          ],
        ),
      )
    );
  }
}
