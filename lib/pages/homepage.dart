import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterbootstrap/pages/settings.dart';
import 'package:flutterbootstrap/pages/todopage.dart';
import 'package:flutterbootstrap/services/firestore.dart';
import 'login.dart';
import 'package:flutterbootstrap/services/firebaseauth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _HomePageState();
  }

  class _HomePageState extends State<HomePage> {

    static const _sidebarMenuTitles = [
      'To Do List',
      'Account Settings',
    ];
    static final _sidebarMenuNavs = [
      const ToDoPage(),
      const SettingsPage(),
    ];

    bool isUserLoggedIn() {
      return FirebaseAuth.instance.currentUser != null;
    }

    void _incrementCounter() {
      setState(() {
        // This call to setState tells the Flutter framework that something has
        // changed in this State, which causes it to rerun the build method below
        // so that the display can reflect the updated values. If we changed
        // _counter without calling setState(), then the build method would not be
        // called again, and so nothing would appear to happen.
        print("state got updtated");
        print("User is current logged: " + isUserLoggedIn().toString());
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: Stack(
          fit: StackFit.expand,
          children: [
            _buildContent(),
          ],
        ),
      );
    }

    PreferredSizeWidget _buildAppBar() {
      return AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
      );
    }

    Widget _buildContent() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          ... _buildListItems(),
          const Spacer(),
          _buildLoginButton()
        ],
      );
    }

    List<Widget> _buildListItems() {
      final ListItems = <Widget>[];
      for (var i = 0; i < _sidebarMenuTitles.length; ++i) {
        ListItems.add(
            Padding(
                padding: const EdgeInsets.symmetric(horizontal:  35, vertical:  10),
                child: SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => _sidebarMenuNavs[i])
                        );
                      },
                      icon: const Icon(Icons.arrow_forward_ios),
                      label: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            _sidebarMenuTitles[i],
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            )
                        ),
                      ),
                    )
                )
            )
        );
      }
      return ListItems;
    }

    Widget _buildLoginButton() {
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: !isUserLoggedIn() ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: Colors.deepPurpleAccent,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 14),
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginPage())
              ).then((_) {
                _incrementCounter();
              });
            },
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          )
          : ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: Colors.deepPurpleAccent,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 14),
            ),
            onPressed: () {
              Future<void> signOut = FirebaseAuth.instance.signOut();
              _incrementCounter();
              },
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          )
        ),
      );
    }
}