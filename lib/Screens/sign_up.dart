import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:untitled/Screens/LoginScreen.dart';
import 'package:untitled/main.dart';
import 'package:untitled/Network/local/Cache.dart';

class SignUp extends StatefulWidget {


  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image:
                    NetworkImage('https://www.amit-learning.com/assets/logo.png'),
                width: 200,
                height: 200,
              ),
              TextFormField(
                controller: nameController ,
                keyboardType: TextInputType.name,
                onFieldSubmitted: (String value) {
                  print("value");
                },
                onChanged: (String value) {
                  print("value");
                },
                decoration: InputDecoration(
                  labelText: "Name",
                  prefixIcon: Icon(Icons.person),
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                controller: emailController ,
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (String value) {
                  print("value");
                },
                onChanged: (String value) {
                  print("value");
                },
                decoration: InputDecoration(
                  labelText: "email address",
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                onFieldSubmitted: (String value) {
                  print("value");
                },
                onChanged: (String value) {
                  print("value");
                },
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
                  suffixIcon: Icon(Icons.remove_red_eye),
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 50,
                    color: Colors.red,
                    child: MaterialButton(
                      onPressed: () {
                        userSignUp(email: emailController.text , name:  nameController.text, password: passwordController.text);
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LoginScreen()),
                      );
                    },
                    child: Text("Go Login"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void userSignUp(
      {required String email,
        required String password,
        required String name}) async {
    //sending data to register api
    final response = await http.post(
      Uri.parse('https://retail.amit-learning.com/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 201) {
      print('you have registered successfully');
      cacheHelper.putData(key: 'isLogin', value: true);
      var token = jsonDecode(response.body)["token"];
      Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) =>  MyApp()));
      // print(token);

    } else {
      throw Exception('Failed to send data');
    }
  }



}
