import 'package:flutter/material.dart';
import 'package:untitled/Models/category.dart';
import 'package:untitled/Network/remote/dio_helper.dart';


class catnew extends StatefulWidget {
  const catnew({Key? key}) : super(key: key);


  @override
  _catnewState createState() => _catnewState();

}


class _catnewState extends State<catnew> {

  static List<Category> itemsCat = [];
  static List<dynamic> category = [];

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);

  }



  @override
  void initState()  {
    super.initState();
    DioHelper.init();
    getCategories();
    print(category.toString());

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // backgroundColor: CupertinoColors.darkBackgroundGray,
        appBar: AppBar(
          backgroundColor: Colors.white,

          elevation: 0,
          title: Text(
            "Category",
            style: TextStyle(
              color: Colors.red,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: GridView.builder(

            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10),
            itemCount:itemsCat.length,
            itemBuilder: (BuildContext ctx, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200.0,
                        decoration: new BoxDecoration(
                          boxShadow: [
                            //background color of box
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3.0,
                                blurRadius: 5.0)
                          ],
                        ),
                        child:
                        Stack(alignment: Alignment.center, children: <Widget>[
                          CircularProgressIndicator(),
                          CircularProgressIndicator(value:0.0),

                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                             itemsCat[index].Avatar.toString(),
                              width: 170,
                              height: 200.0,
                              fit: BoxFit.fill,
                            ),
                          ),

                          Text(
                            itemsCat[index].Name.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.black38,
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0),
                          ),

                        ]),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

   void getCategories() async {

    DioHelper.getData("api/categories").then((value) {
      itemsCat.clear();
      category.clear();
      category = value.data['categories'];
      print(itemsCat.toString());

      print(category[4]['id']);

      setState(() {
        for (int i = 0; i < category.length; i++) {
          itemsCat.add(Category(
              category[i]['id'], category[i]['name'], category[i]['avatar']));
        }

      });
    }).catchError((onError) {
      print(onError.toString());
    });
  }



}
