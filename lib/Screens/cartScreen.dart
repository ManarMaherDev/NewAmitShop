import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/Cubit/BlocStates.dart';
import 'package:untitled/Cubit/Cubit.dart';
import 'package:untitled/Network/local/Cache.dart';
import 'package:untitled/Screens/LoginScreen.dart';
import 'package:untitled/Screens/sign_up.dart';

class cartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      AppCubit()
        ..createDB()
        ..getDataFromDatabase(AppCubit.db),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          AppCubit()
            ..createDB();
        },
        builder: (BuildContext context, AppStates state) {


          AppCubit cubit = AppCubit.get(context);
          cubit.createDB();
          var item = AppCubit
              .get(context)
              .newItems;

          print('list 1 ' + item.length.toString());

          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,

                elevation: 0,
                title: Text(
                  "Cart",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: Column(
                children: [

                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height - 260,
                    child: ListView.builder(
                      itemCount: item.length,
                      itemBuilder: (context, index) =>
                          Card(
                            child: ListTile(
                              leading: SizedBox(
                                height: 70.0,
                                width: 60.0,

                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(3.0),

                                  child: Image.network(
                                    item[index]['avatar'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              //add here
                              title: Text(
                                item[index]['name'],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  height: 30,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFEACECE),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(5)),

                                  child: Text(
                                      item[index]['price'].toString() + " EGP",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(
                                              0xFFA83434),
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),


                              trailing: SizedBox(

                                width: 70,
                                height: 20,
                                child: Container(

                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white),
                                  child: Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            if (item[index]['count'] != 1) {
                                              cubit.updateData(
                                                  count: item[index]['count'] -
                                                      1,
                                                  id: item[index]['id']);
                                            }
                                          },
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.black,
                                            size: 20,
                                          )),
                                      Container(
                                        // margin: EdgeInsets.symmetric(horizontal: 3),

                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                3),
                                            color: Colors.white),
                                        child: Text(
                                          item[index]['count'].toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            cubit.updateData(
                                                count: item[index]['count'] + 1,
                                                id: item[index]['id']);
                                          },
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.black,
                                            size: 20,
                                          )),
                                    ],
                                  ),
                                ),
                              ),

                              onTap: () {},
                            ),
                          ),
                    ),
                  ),
                  Divider(thickness: 0.1, color: Colors.black),
                  ListTile(
                    leading: Text(
                      "Total : ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title:Row(
                      children: [
                        Text(
                          cubit.getTotalPrice() + "" ,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                           " EGP",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(8),
                        fixedSize: Size(100, 30),
                        primary: Colors.red,
                      ),
                      onPressed: () {

                          showDialog(context: context, builder: (context)=>AlertDialog(
                            title: Text('Check Out'),
                            content: Text('Do you want to send a request? The total amount is: ' + cubit.getTotalPrice().toString() + " EGP"),
                            actions: [
                              FlatButton(
                                textColor: Colors.red,
                                onPressed: () {
                                  Navigator.pop(context, context);
                                },
                                child: Text('Cancel'),
                              ),
                              FlatButton(
                                textColor: Colors.red,
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) =>  LoginScreen()));
                                },

                                child: Text('Pay'),
                              ),
                            ],
                          ));
                      },
                      child: Text("Check Out"),
                    ),

                  ),
                ],
              ));
        },
      ),
    );
  }


}
