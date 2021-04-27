import 'dart:ui';
import 'dart:convert';
import 'dart:io';
import 'file:///E:/Flutter/ecom_admin/lib/Subcategorypages/addSubCategory.dart';
import 'package:http/http.dart' as http;
import 'file:///E:/Flutter/ecom_admin/lib/Categorypages/editcategory.dart';

import 'file:///E:/Flutter/ecom_admin/lib/Productpages/products.dart';
import 'package:ecom_admin/services/crudsubcategory.dart';
import 'package:flutter/material.dart';

class subcategory extends StatefulWidget {

  final String categoryid, categoryname, subcategoryid, subcategoryname;

  const subcategory({Key key, this.categoryid, this.categoryname, this.subcategoryid, this.subcategoryname}) : super(key: key);

  @override
  _subcategoryState createState() => _subcategoryState();
}

class _subcategoryState extends State<subcategory> {

  final String url = "http://192.168.43.82/Eassymart/VersionCode1/Admin/getSubCategory.php";
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.post(
        url,
        body: {
          "category_id": "${widget.categoryid}"
        },
        headers: {"Accept": "application/json"});
    print(response.body);
    setState(() {
      var convertDataTojson = jsonDecode(response.body.toString());
      data = convertDataTojson['sub_category'];
      print(data);
    });
    return "success";
  }

  final TextEditingController subcategoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Sub-Category"),
              Text("${widget.categoryname}",
                  style: TextStyle(fontSize: 12.0), textAlign: TextAlign.right)
            ],
          ),
          backgroundColor: Color(0xFFF40c1c),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => editcategory(categoryid: "${widget.categoryid}", categoryname: "${widget.categoryname}" )));
              },
            ),

          ],
        ),
        body: Stack(
          children: <Widget>[
            ListView.builder(
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (BuildContext context, int index) {
                  // const spinkit = SpinKitRotatingCircle(
                  //   color: Colors.red,
                  //   size: 50.0,
                  // );

                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: ListTile(
                            leading: Image.network(
                              'http://192.168.43.82/Eassymart/uploads/Subcategory/' +
                                  data[index]['subcategory_id'] +
                                  '.jpeg',
                              fit: BoxFit.fill,
                            ),
                            title: SizedBox(
                                height: 25,
                                child: Text(
                                  data[index]['subcategory_name'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),


                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => products(
                                      categoryid: data[index]['category_id'],
                                      categoryname: data[index]['category_name'],
                                      subcategoryid: data[index]['subcategory_id'],
                                      subcategoryname: data[index]['subcategory_name']
                                  )));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 5,
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            Positioned(
              right: 20,
              bottom: 20,
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  backgroundColor: Color(0xFFF40c1c),
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => addsubcategory(categoryid: "${widget.categoryid}", categoryname: "${widget.categoryname}")));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
