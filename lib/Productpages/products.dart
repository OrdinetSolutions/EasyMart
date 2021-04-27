
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecom_admin/Productpages/addproduct.dart';
import 'file:///E:/Flutter/ecom_admin/lib/Subcategorypages/editsubcategory.dart';
import 'package:flutter/material.dart';
import 'file:///E:/Flutter/ecom_admin/lib/Productpages/editproduct.dart';

class products extends StatefulWidget {

  final String categoryid, categoryname;
  final String subcategoryid, subcategoryname;

  const products({Key key,  this.categoryid, this.categoryname, this.subcategoryid, this.subcategoryname}) : super(key: key);

  @override
  _productsState createState() => _productsState();
}
class _productsState extends State<products> {

  final String url = "http://192.168.43.82/Eassymart/VersionCode1/Admin/getProductsBySubCategory.php";
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
          "subcategory_id": "${widget.subcategoryid}"
        },
        headers: {"Accept": "application/json"});
    print(response.body);
    setState(() {
      var convertDataTojson = jsonDecode(response.body.toString());
      data = convertDataTojson['product'];
      print(data);
    });
    return "success";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add product"),
              Text("${widget.subcategoryname}", style: TextStyle(fontSize: 12.0), textAlign: TextAlign.right)
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => editsubcategory(
                        subcategoryid: "${widget.subcategoryid}", subcategoryname: "${widget.subcategoryname}",
                        categoryid: "${widget.categoryid}", categoryname: "${widget.categoryname}"
                    )));
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
                              'http://192.168.43.82/Eassymart/uploads/Product/' +
                                  data[index]['product_id'] +
                                  '.jpeg',
                              fit: BoxFit.fill,
                            ),
                            title: SizedBox(
                                height: 25,
                                child: Text(
                                  data[index]['product_name'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),

                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => editproduct(
                                    categoryid: "${widget.categoryid}",
                                    categoryname: "${widget.categoryname}",
                                    subcategoryid: "${widget.subcategoryid}",
                                    subcategoryname: "${widget.subcategoryname}",
                                    productid: data[index]['product_id'],
                                    productname: data[index]['product_name'],
                                    productdesc: data[index]['product_desc'],
                                    originalprice: data[index]['original_price'],
                                    sellingprice: data[index]['selling_price'],
                                    prodavailibility: data[index]['availibility'],
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => addproduct(
                            categoryid: "${widget.categoryid}", categoryname: "${widget.categoryname}",
                            subcategoryid: "${widget.subcategoryid}", subcategoryname: "${widget.subcategoryname}"
                        )));
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
