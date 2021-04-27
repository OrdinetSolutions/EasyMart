import 'dart:convert';

import 'package:ecom_admin/Categorypages/category.dart';
import 'package:ecom_admin/services/crudcategory.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class addcategory extends StatefulWidget {
  @override
  _addcategoryState createState() => _addcategoryState();
}

class _addcategoryState extends State<addcategory> {
  final TextEditingController categorynameController =
      TextEditingController(); //calliing the method from service folder

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

  /*----------------------------------------------*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Add Category"),
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
                      color: Color(0xFFA9A9A9),
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
                    controller: categorynameController,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.bookmark,
                        color: Colors.black,
                      ),
                      labelText: 'Enter Category Name',
                      focusColor: Colors.black,
                    ),
                  ),
                ),
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
                final String categoryname = categorynameController.text;

                await addCategory(categoryname, base64Image);

                setState(() async {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => category()));
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
