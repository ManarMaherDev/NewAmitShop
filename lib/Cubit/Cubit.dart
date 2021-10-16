import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/Cubit/BlocStates.dart';
import 'package:untitled/Network/local/Cache.dart';
import 'package:untitled/Screens/Home.dart';
import 'package:untitled/Screens/NewCat.dart';
import 'package:untitled/Screens/cartScreen.dart';
import 'package:untitled/Screens/menu.dart';
import '../Screens/LoginScreen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  int currentIndex = 0;
  int counter = 1;
  int total = 0;

  List<Widget> pageList = [
    HomeScreen(),
    catnew(),
    cartScreen(),
    MenuScreen(),
  ];

  static AppCubit get(context) => BlocProvider.of(context);
  static late Database db;
  List<Map> newItems = [];

  void BottomTap(int index) {

    currentIndex = index;

    emit(AppChangeBottomNabBarState());
  }

  void minus() {
    if (counter != 1) {
      counter--;
    }

    emit(CounterMinusState());
  }

  void plus() {
    counter++;
    emit(CounterPlusState());
  }

  void createDB() async {
    db = await openDatabase('cart.db', version: 1, onCreate: (db, version) {
      db
          .execute(
              'CREATE TABLE cartItems (id INTEGER PRIMARY KEY, name TEXT,count	INTEGER,price	INTEGER,avatar TEXT)')
          .then((value) {
        print("created");
      }).catchError((onError) {
        print("error in db create" + onError.toString());
      });
    }, onOpen: (db) {
      print("opened here here");
      getDataFromDB(db).then((value) {
        for (int i = 0; i < value.length; i++) {
          newItems.add(value[i]);
        }

        emit(AppCreateDatabaseState());
      });
    });
  }

  insertToDatabase(
      int id, String name, String avatar, int count, int price) async {
    await db.transaction((txn) async {
      return txn
          .rawInsert(
              'INSERT INTO cartItems (id , name , count, price , avatar) VALUES ($id , "$name" , $count , $price , "$avatar" )')
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());
        getDataFromDB(db).then((value) {
          print('$value getted successfully');
          // newTasks = value;
          for (int i = 0; i < value.length; i++) {
            newItems.add(value[i]);
          }

          print(newItems);
          emit(AppGetDatabaseState());
        });
        //getDataFromDatabase(db);
      }).catchError((error) {
        print('Error when inserting new record ${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database) {
    database.rawQuery('SELECT * FROM cartItems').then((value) {
      newItems = value;
      emit(AppGetDatabaseState());
    });
  }

  ///////////////////////////////////////////////
//dont use that
  static Future insertToDB(
      int id, String name, String avatar, int count, int price) async {
    return await db.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO cartItems (id , name , count, price , avatar) VALUES ($id , "$name" , $count , $price , "$avatar" )')
          .then((value) {
        print("added");

        getDataFromDB(db);
      }).catchError((onError) {
        print("error when insert " + onError.toString());
      });
    });
  }

// dont use that
  static Future<List<Map>> getDataFromDB(Database db) async {
    return await db.rawQuery('SELECT * FROM cartItems');
  }

  String getTotalPrice() {
    String s = "0";
    if (newItems.isEmpty != true) {
      total = 0;
      for (int i = 0; i < newItems.length; i++) {
        total = (newItems[i]['price'] * newItems[i]['count']) + total;
      }
    }

    s = total.toString();

    return s;
  }

  void updateData({
    required int count,
    required int id,
  }) async {
    return await db.rawUpdate(
      'UPDATE cartItems SET count = ? WHERE id = ?',
      ['$count', '$id'],
    ).then((value) {
      getDataFromDatabase(db);
      emit(AppUpdatetDatabaseState());
    });
  }




}
