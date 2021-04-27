import 'dart:convert';

import 'package:ecom_admin/Productpages/products.dart';
import 'package:ecom_admin/services/crudProduct.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class addproduct extends StatefulWidget {

  final String categoryid, categoryname;
  final String subcategoryid, subcategoryname;

  const addproduct({Key key, this.categoryid, this.categoryname, this.subcategoryid, this.subcategoryname,}) : super(key: key);

  @override
  _addproductState createState() => _addproductState();
}

class _addproductState extends State<addproduct> {

  final TextEditingController productnameController =
  TextEditingController(); //calliing the method from service folder
  final TextEditingController productdescController =
  TextEditingController(); //calliing the method from service folder
  final TextEditingController productoriginalpriceController =
  TextEditingController(); //calliing the method from service folder
  final TextEditingController productsellingpriceController =
  TextEditingController(); //calliing the method from service folder
  final TextEditingController availibilityController =
  TextEditingController(); //calliing the method from service folder


  bool _isChecked = true;
  String _currText = '';

  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }


  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }


  /*------------------------------------------------------------*/


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Add Product"),
          backgroundColor: Color(0xFFF40c1c),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        content: Container(
                          child: Column(
                            children: [
                              Text(
                                "Are you sure to delete this product ?",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FlatButton(
                                  child: Text("Yes "),
                                  onPressed: () {
                                    // your code
                                  }),
                              FlatButton(
                                  child: Text("No"),
                                  onPressed: () {
                                    // your code
                                  }),
                            ],
                          )
                        ],
                      );
                    });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 32,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      //_showPicker(context);
                      chooseImage();

                    },
                    child: Container(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          SizedBox(
                            height: 20.0,
                          ),
                          showImage(),
                          SizedBox(
                            height: 20.0,
                          ),

                          SizedBox(
                            height: 20.0,
                          ),

                          Text(
                            status,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, top: 5.0, right: 20.0, bottom: 5.0),
                  child: TextFormField(
                    controller:productnameController,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.bookmark,
                        color: Colors.black,
                      ),
                      labelText: 'Enter product Name',
                      focusColor: Colors.black,
                    ),
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, top: 5.0, right: 20.0, bottom: 5.0),
                  child: TextFormField(
                    controller:productdescController,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.description,
                        color: Colors.black,
                      ),
                      labelText: 'Enter product description',
                      focusColor: Colors.black,
                    ),
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, top: 5.0, right: 20.0, bottom: 5.0),
                  child: TextFormField(
                    controller:productoriginalpriceController,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.money,
                        color: Colors.black,
                      ),
                      labelText: 'Enter Original price',
                      focusColor: Colors.black,
                    ),
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, top: 5.0, right: 20.0, bottom: 5.0),
                  child: TextFormField(
                    controller:productsellingpriceController,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.money,
                        color: Colors.black,
                      ),
                      labelText: 'Enter selling price',
                      focusColor: Colors.black,
                    ),
                  ),

                ),
//checkbox
                CheckboxListTile(
                  title: Text("available"),
                  value: _isChecked,
                  onChanged: (val) {
                    setState(() {
                      _isChecked = val;
                      if (val == true) {
                        _currText = "1";
                      }
                    });
                  },
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 50.0,
            child: RawMaterialButton(
              child: Text(
                "Add",
                style: (TextStyle(fontSize: 18.0, color: Colors.white)),
              ),
              fillColor: Colors.red,
              onPressed: () async {
                final String productname = productnameController.text;
                final String productdesc = productdescController.text;
                final String productoriginalprice = productoriginalpriceController.text;
                final String productsellingprice = productsellingpriceController.text;
                final String availibility = availibilityController.text;

                await addProduct("${widget.categoryid}", "${widget.subcategoryid}" ,productname,productdesc,productoriginalprice,
                    productsellingprice,availibility, base64Image);

                setState(() async {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => products(
                          categoryid: "${widget.categoryid}", categoryname: "${widget.categoryname}",
                          subcategoryid: "${widget.subcategoryid}", subcategoryname: "${widget.subcategoryname}"
                      )));
                });
                // Navigator.push(context,MaterialPageRoute(builder: (context)=>bottom()));
              },
            ),
          ),
        ),
      ),
    );
  }
}
