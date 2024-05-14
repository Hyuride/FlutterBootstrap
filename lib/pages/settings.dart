import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterbootstrap/pages/signup.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {

  final TextEditingController newPasswordController = TextEditingController();

  void openNoteBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          obscureText: true,
          controller: newPasswordController,
          decoration: const InputDecoration(
              labelText: 'New Password'
          )
        ),
        actions: [
          TextButton(
            onPressed: () {
              changePassword(newPasswordController.text);
              },
            child: Text("Submit"),
          )
        ],
      ),
    );
  }

  void changePassword(String newPassword) async {
    final user = await FirebaseAuth.instance.currentUser;
    user?.updatePassword(newPassword).then((_) {
      print('Success');
      newPasswordController.clear();
      Navigator.pop(context);
    }).catchError((error) {
      print("Error");
    });
  }

  @override
  Widget build(BuildContext context) {
    if(FirebaseAuth.instance.currentUser != null){
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            title: const Text('Account Settings'),
          ),
          body: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.deepPurpleAccent,
                            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 14),
                          ),
                          onPressed: () {
                            openNoteBox();
                          },
                          child: const Text(
                            'Change Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ]
          )
      );
    }
    else{
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            title: const Text('Account Settings'),
          ),
          body: ListView(
              children: [
                Container(
                    child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Container(
                                margin: const EdgeInsets.only(top: 20, bottom: 10),
                                child: const Text(
                                    'Please Log In',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w500
                                    )
                                )
                            )
                        )
                    )
                )
              ]
          )
      );

    }
  }
}
