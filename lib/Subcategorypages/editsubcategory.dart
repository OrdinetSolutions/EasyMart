import 'dart:convert';
import 'dart:io';

import 'package:ecom_admin/Subcategorypages/subcategory.dart';
import 'package:ecom_admin/services/crudsubcategory.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class editsubcategory extends StatefulWidget {

  final String subcategoryid, subcategoryname, categoryid, categoryname;

  const editsubcategory({Key key, this.subcategoryid, this.subcategoryname, this.categoryid, this.categoryname}) : super(key: key);

  @override
  _editsubcategoryState createState() => _editsubcategoryState();
}

class _editsubcategoryState extends State<editsubcategory> {

  final TextEditingController subcategorynameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    //initial();
    super.initState();
    initial();

  }

  void initial() async{

    setState(() {

      subcategorynameController.text= "${widget.subcategoryname}";

    });
  }


/*-------------------------------image upload start---------------------------------------*/
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
//-------------------------img end-------------------------


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Edit sub-Category"),
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
                                "Are you sure to delete this category ?",
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

                                    await deleteSubCategory("${widget.subcategoryid}".toString());

                                    setState(() async {

                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) => subcategory(
                                              categoryid: "${widget.categoryid}", categoryname: "${widget.categoryname}"
                                          )));

                                    }
                                    );


                                  },),
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
                    controller:subcategorynameController,
                    validator: (val) =>(val.length==0 ?'This field is required':null),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.bookmark,
                        color: Colors.black,
                      ),
                      labelText: 'Enter sub-Category Name',
                      focusColor: Colors.black,
                      //contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
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
                "Update",
                style: (TextStyle(fontSize: 18.0, color: Colors.white)),
              ),
              fillColor: Colors.red,
              onPressed: () async {
                final String subcategoryname = subcategorynameController.text;

                await updateSubCategory("${widget.subcategoryid}",subcategoryname);

                setState(() async {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => subcategory(
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
