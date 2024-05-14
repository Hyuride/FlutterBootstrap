import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterbootstrap/pages/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                child: const Text(
                    'Login',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w500
                  )
                ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                child: TextField(
                  controller: emailController,
                  obscureText: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:  35, vertical:  16),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurpleAccent
                    ),
                    onPressed: () {
                      Future<UserCredential> result = FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                      );
                      result.then((value) {
                        print('Successfully Logged In');
                        print(FirebaseAuth.instance.currentUser != null);
                        Navigator.pop(context);
                      });
                      result.catchError((error) {
                        print('Error');
                        print(error.toString());
                      });
                    },
                    child: Text('Login'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:  35, vertical:  16),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurpleAccent
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignupPage())
                      );
                    },
                    child: Text('Sign Up'),
                  ),
                ),
              ),
            ],
          )
        ]
      ),
    );
  }
}
