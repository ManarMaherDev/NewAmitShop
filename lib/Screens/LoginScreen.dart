import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:untitled/Network/local/Cache.dart';
import 'package:untitled/Network/remote/dio_helper.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Screens/sign_up.dart';
import '../main.dart';
import 'Home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Image(
                  image:
                      NetworkImage('https://www.amit-learning.com/assets/logo.png'),
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 300,
                  height: 70,
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 300,
                  height: 70,
                  child: TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password',
                      suffixIcon: Icon(Icons.remove_red_eye),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 150,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      shape: StadiumBorder(),
                      textStyle: const TextStyle(
                        fontSize: 20,
                      ),
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      userLogin(emailController.text, passwordController.text);
                    },
                    child: const Text('Login'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Need an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SignUp()),
                        );
                      },
                      child: Text("Go SignUp"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  userLogin(String email, String password) async {
    //sending data to login api
    final response = await http.post(
      Uri.parse('https://retail.amit-learning.com/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      print('signed in successfully');
      cacheHelper.putData(key: 'isLogin', value: true);
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => MyApp()));
      var token = jsonDecode(response.body)['token'];
    } else {
      throw Exception('Failed to login');
    }
  }
}
