import 'dart:convert';

import 'file:///E:/Flutter/ecom_admin/lib/Categorypages/addcategory.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'file:///E:/Flutter/ecom_admin/lib/Subcategorypages/subcategory.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class category extends StatefulWidget {
  @override
  _categoryState createState() => _categoryState();
}

class _categoryState extends State<category> {
  static final String uploadEndPoint =
      'http://192.168.43.82/Eassymart/VersionCode1/Admin/upload_img.php';
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
/*--------------------------------------------------------------------------*/

  final String url =
      "http://192.168.43.82/Eassymart/VersionCode1/Admin/getCategory.php";
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(
        //encode the url
        Uri.encodeFull(url),
        //json response
        headers: {"Accept": "application/json"});
    print(response.body);

    setState(() {
      var convertDataTojson = jsonDecode(response.body);
      data = convertDataTojson['category'];
    });
    return "success";
  }

/*-------------------------------------------------------read data end----------------------------*/

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

  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

  upload(String fileName) {
    http.post(uploadEndPoint, body: {
      "image": base64Image,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }

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
                              'http://192.168.43.82/Eassymart/uploads/category/' +
                                  data[index]['category_id'] +
                                  '.jpeg',
                              fit: BoxFit.fill,
                            ),
                            title: SizedBox(
                                height: 25,
                                child: Text(
                                  data[index]['category_name'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => subcategory(
                                      categoryid: data[index]['category_id'],
                                      categoryname: data[index]['category_name'])));
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
                        MaterialPageRoute(builder: (context) => addcategory()));
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
