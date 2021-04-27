import 'dart:convert';

import 'package:ecom_admin/Productpages/products.dart';
import 'package:ecom_admin/services/crudProduct.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class editproduct extends StatefulWidget {
  final String categoryid,
      categoryname,
      subcategoryid,
      subcategoryname,
      productid,
      productname,
      productdesc,
      originalprice,
      sellingprice,
      prodavailibility;

  const editproduct(
      {Key key,
      this.categoryid,
      this.categoryname,
      this.subcategoryid,
      this.subcategoryname,
      this.productid,
      this.productname,
      this.productdesc,
      this.originalprice,
      this.sellingprice,
      this.prodavailibility})
      : super(key: key);

  @override
  _editproductState createState() => _editproductState();
}

class _editproductState extends State<editproduct> {
  final TextEditingController productnameController = TextEditingController();
  final TextEditingController productdescController = TextEditingController();
  final TextEditingController originalpriceController = TextEditingController();
  final TextEditingController sellingpriceController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    //initial();
    super.initState();
    initial();
  }

  void initial() async {
    setState(() {
      productnameController.text = "${widget.productname}";
      productdescController.text = "${widget.productdesc}";
      originalpriceController.text = "${widget.originalprice}";
      sellingpriceController.text = "${widget.sellingprice}";
    });
  }

  bool _isChecked = true;
  String _currText = '1';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Edit product"),
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
                                  onPressed: () async {
                                    await deleteProduct(
                                        "${widget.productid}".toString());

                                    setState(() async {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => products(
                                                  categoryid:
                                                      "${widget.categoryid}",
                                                  categoryname:
                                                      "${widget.categoryname}",
                                                  subcategoryid:
                                                      "${widget.subcategoryid}",
                                                  subcategoryname:
                                                      "${widget.subcategoryname}")));
                                    });
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
                    controller: productnameController,
                    validator: (val) =>
                        (val.length == 0 ? 'This field is required' : null),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.bookmark,
                        color: Colors.black,
                      ),
                      labelText: 'Enter Category Name',
                      focusColor: Colors.black,
                      //contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, top: 5.0, right: 20.0, bottom: 5.0),
                  child: TextFormField(
                    controller: productdescController,
                    validator: (val) =>
                        (val.length == 0 ? 'This field is required' : null),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.description,
                        color: Colors.black,
                      ),
                      labelText: 'Enter Product Description',
                      focusColor: Colors.black,
                      //contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, top: 5.0, right: 20.0, bottom: 5.0),
                  child: TextFormField(
                    controller: originalpriceController,
                    validator: (val) =>
                        (val.length == 0 ? 'This field is required' : null),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.money,
                        color: Colors.black,
                      ),
                      labelText: 'Enter original Price',
                      focusColor: Colors.black,
                      //contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, top: 5.0, right: 20.0, bottom: 5.0),
                  child: TextFormField(
                    controller: sellingpriceController,
                    validator: (val) =>
                        (val.length == 0 ? 'This field is required' : null),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.money,
                        color: Colors.black,
                      ),
                      labelText: 'Enter selling price',
                      focusColor: Colors.black,
                      //contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, top: 5.0, right: 20.0, bottom: 5.0),
                    child: CheckboxListTile(
                      title: Text("available"),
                      value: _isChecked,
                      onChanged: (val) {
                        setState(() {
                          _isChecked = val;
                          if (val == true) {
                            _currText = "1";
                          } else if (val == false) {
                            _currText = "0";
                          }
                        });
                      },
                    )),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 50.0,
            child: RawMaterialButton(
              child: Text(
                "Update",
                style: (TextStyle(fontSize: 18.0, color: Colors.white)),
              ),
              fillColor: Colors.red,
              onPressed: () async {
                final String productname = productnameController.text;
                final String productdesc = productdescController.text;
                final String originalprice = originalpriceController.text;
                final String sellingprice = sellingpriceController.text;
                final String avalibility = _currText;

                await updateProduct("${widget.productid}", productname,
                    productdesc, originalprice, sellingprice, avalibility);

                setState(() async {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => products(
                              categoryid: "${widget.categoryid}",
                              categoryname: "${widget.categoryname}",
                              subcategoryid: "${widget.subcategoryid}",
                              subcategoryname: "${widget.subcategoryname}")));
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
