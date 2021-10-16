import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/Cubit/BlocStates.dart';
import 'package:untitled/Cubit/Cubit.dart';
import 'package:untitled/Models/Products.dart';
import 'package:untitled/Network/remote/dio_helper.dart';

import 'ProductItem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static List<Products> itemsProducts = [];
  static List<dynamic> ProductsJson = [];

  @override
  void initState() {
    super.initState();
    DioHelper.init();
    getProducts();

  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,

          elevation: 0,
          title: Text(
            "Home",
            style: TextStyle(
              color: Colors.red,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 8.0 / 9.0,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: itemsProducts.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductItemScreen(itemsProducts[index])),
                );
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 15.0 / 8.0,
                      child: Image.network(
                        itemsProducts[index].avatar.toString(),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                      child: Column(
                        mainAxisSize:MainAxisSize.min,
                        children: <Widget>[
                          Text(itemsProducts[index]
                              .name
                              .substring(0, 16)
                              .toString() +
                              " .."),
                          const SizedBox(height: 8.0),

                          ListTile(

                            leading:Text(itemsProducts[index].price.toString() +
                                " EGP"),

                            trailing:   IconButton(
                              padding: EdgeInsets.fromLTRB(0,0,0,5),
                              iconSize: 30,
                          icon: new Icon(
                          Icons.add_box_rounded,

                            color: Colors.red,
                          ),
                onPressed: () {
                  cubit.insertToDatabase(itemsProducts[index].id, itemsProducts[index].name, itemsProducts[index].avatar, 1, itemsProducts[index].price);

                },
              ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void getProducts() async {
    DioHelper.getData("api/products").then((value) {
      itemsProducts.clear();
      ProductsJson.clear();
      ProductsJson = value.data['products'];
    //  print(ProductsJson.toString());

      //print(ProductsJson[4]['id']);

      setState(() {
        var NullText = '';
        //  print(ProductsJson[0]['id']);

        for (int i = 0; i < ProductsJson.length; i++) {

          itemsProducts.add(Products(
            ProductsJson[i]['id'],
            ProductsJson[i]['name'],
            ProductsJson[i]['title'],
            ProductsJson[i]['avatar'],
            ProductsJson[i]['category_id'],
            ProductsJson[i]['price'],
            ProductsJson[i]['description'].toString(),
          ));
        }
      });
    }).catchError((onError) {
      print(onError.toString());
    });
  }
}
