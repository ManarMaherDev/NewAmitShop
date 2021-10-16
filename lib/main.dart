import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/Cubit/Cubit.dart';
import 'package:untitled/Network/local/Cache.dart';
import 'package:untitled/Screens/Home.dart';
import 'package:untitled/Screens/cartScreen.dart';
import 'package:untitled/Screens/NewCat.dart';

import 'Cubit/BlocStates.dart';
import 'Cubit/constants.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/sign_up.dart';




void main() {

  runApp(MyApp());
  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amit Store',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit()..createDB(),
      child: BlocConsumer<AppCubit , AppStates>(

        listener: (BuildContext context, AppStates state) {
          AppCubit()..createDB();
        },
        builder: (BuildContext context,AppStates state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
          body:cubit.pageList[cubit.currentIndex] ,
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.black38,
            currentIndex: cubit.currentIndex,
            onTap: cubit.BottomTap,
            type: BottomNavigationBarType.fixed,
            //fixedColor: Colors.red,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'category',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: 'cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'menu',
              ),
            ],
          ),
        );
      },

      ),
    );
  }



  }

