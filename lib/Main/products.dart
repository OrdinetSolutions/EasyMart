import 'package:flutter/material.dart';

class products extends StatefulWidget {
  @override
  _productsState createState() => _productsState();
}

class _productsState extends State<products> {
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
          /*actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add_box,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => addsubcategory()));
              },
            ),
          ],*/
        ),
        body: Stack(
          children: <Widget>[
            ListView.builder(
                itemCount: 5, //data == null ? 0 : data.length,
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
                              'https://ministryofcurry.com/wp-content/uploads/2017/10/IMG_8124.jpg',
                              fit: BoxFit.fill,
                            ),
                            title: SizedBox(
                                height: 25,
                                child: Text(
                                  "garam masala", //data[index]['batches']['batchName'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),

                            /*onTap: (){

                          Navigator.push(context,
                            new MaterialPageRoute(builder: (context) => study_material(batch : data[index]['batches']['batchName'], des: data[index]['batches']['description'],batchId: data[index]['batches']['id'].toString())
                            ),
                          );
                        },*/

                            onTap: () {},
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
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            scrollable: true,
                            title: Text('Add Product'),
                            content: Container(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      autovalidateMode: AutovalidateMode.always,
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.note_add,
                                          color: Colors.black,
                                        ),
                                        labelText: 'Enter Product name',
                                        focusColor: Colors.black,
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    RaisedButton(
                                        color: Colors.blue[300],
                                        child: Text("Upload image"),
                                        onPressed: () {
                                          // your code
                                        }),
                                  ],
                                )),
                            actions: [
                              RaisedButton(
                                  child: Text("Submit"),
                                  onPressed: () {
                                    // your code
                                  }),
                            ],
                          );
                        });
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
