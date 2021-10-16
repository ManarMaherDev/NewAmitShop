import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/Cubit/BlocStates.dart';
import 'package:untitled/Cubit/Cubit.dart';

import '../Models/Products.dart';

class ProductItemScreen extends StatelessWidget {
  final Products Product;

  const ProductItemScreen(this.Product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit()..createDB(),
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (BuildContext context, AppStates state) { AppCubit()..createDB(); },
        builder: (BuildContext context,AppStates state) {
          AppCubit cubit = AppCubit.get(context);

          return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                },
                icon: Icon(Icons.arrow_back_ios),
                color: Color(
                    0xFFFC0000),
              ),

              title: Text(
                Product.title,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(
                      0xFFFF0000),                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Column(
              children: [

                Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              Product.avatar,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              Product.title,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            Row(
                              children: [

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 30,
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        color: Color(0xFFCEEAD6),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(5)),

                                    child: Text(
                                        Product.price.toString() + " EGP",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(
                                                0xFF34A853),
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width-300),
                                ),
                                Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.red),
                                  child: Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                          cubit.minus();
                                          },
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 16,
                                          )),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 3),
                                        padding:
                                        EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(3),
                                            color: Colors.white),
                                        child: Text(
                                          cubit.counter.toString(),
                                          style: TextStyle(color: Colors.black, fontSize: 15),
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                          cubit.plus();
                                          },
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 16,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Divider(color: Colors.black),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Description",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              Product.title.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              Product.description.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),

                ),

                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(

                    style:  ElevatedButton.styleFrom(

                      padding: EdgeInsets.all(8),
                      fixedSize: Size(MediaQuery.of(context).size.width , 50),
                      primary:Colors.red ,
                    ),
                    onPressed: () {
                      cubit.insertToDatabase(Product.id, Product.name, Product.avatar, cubit.counter, Product.price);
                      print(cubit.counter);
                      //  DataStorage.insertToDB(Product.id, Product.name, Product.avatar, CountItem, Product.price);
                    },
                    child: Text("Add To Cart"),
                  ),
                ),
              ],
            ),
          ),
        );
        },
      ),
    );
  }
}
