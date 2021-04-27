//import 'package:ecom_admin/Addproductpages/editcategory.dart';
import 'package:ecom_admin/Login/contactus.dart';
import 'package:ecom_admin/Main/addsliderimages.dart';
import 'file:///E:/Flutter/ecom_admin/lib/Categorypages/category.dart';
import 'package:ecom_admin/Main/completedorders.dart';
import 'package:ecom_admin/Main/rejectedorders.dart';
import 'file:///E:/Flutter/ecom_admin/lib/Servicescategory/services.dart';
import 'package:flutter/material.dart';

class pendingrequest extends StatefulWidget {
  @override
  _pendingrequestState createState() => _pendingrequestState();
}

class _pendingrequestState extends State<pendingrequest> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pending Orders"),
          backgroundColor: Color(0xFFF40c1c),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => category()));
              },
            ),
            PopupMenuButton<String>(
              itemBuilder: (context) => [
                PopupMenuItem(
                  //value: 0,
                  child: Text(
                    "Add Slider Images",
                    //style: TextStyle(fontWeight: FontWeight.w700),
                  ),

                ),

              ],
              onSelected: (result) {
                if(result == 0){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => addsliderimages()));
                }
              },
            )
          ],
        ),
        body: ListView.builder(
            itemCount: 4, //data == null ? 0 : data.length,
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
                        /*leading: Image.network(
                          'https://ministryofcurry.com/wp-content/uploads/2017/10/IMG_8124.jpg',
                          fit: BoxFit.fill,
                        ),*/
                        title: SizedBox(
                            height: 25,
                            child: Text(
                              "rashi pawar", //data[index]['batches']['batchName'],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                        // subtitle: Text(data[index]['batches']['id'].toString()),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Desi ghee", //data[index]['batches']['description'],
                              style: TextStyle(fontSize: 18), maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Status : ", //data[index]['batches']['description'],
                                  style: TextStyle(fontSize: 18), maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),
                                Text(
                                  "Pending", //data[index]['batches']['description'],
                                  style: TextStyle(fontSize: 18), maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),
                              ],
                            ),
                          ],
                        ),
                        /*onTap: (){

                          Navigator.push(context,
                            new MaterialPageRoute(builder: (context) => study_material(batch : data[index]['batches']['batchName'], des: data[index]['batches']['description'],batchId: data[index]['batches']['id'].toString())
                            ),
                          );
                        },*/

                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: Text('Order Details'),
                                  content: Container(
                                      child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Name : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("dinesh Kartik"),
                                        ],
                                      ),
                                      SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Text(
                                            "Contact No. :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("1122336655"),
                                        ],
                                      ),
                                      SizedBox(height: 10.0),
                                      Wrap(
                                        children: [
                                          Text(
                                            "Address :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              "nfdnewufnwfndqndoqenoqnioqdnqodnqdoqqndnc jfdjfnd jsfjdfnd"),
                                        ],
                                      ),
                                      SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Text(
                                            "Product name :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("Garam masala"),
                                        ],
                                      ),
                                      SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Text(
                                            "Quantity :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("5"),
                                        ],
                                      ),
                                      SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Text(
                                            "Price :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("5000"),
                                        ],
                                      ),
                                    ],
                                  )),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        RaisedButton(
                                            child: Text("Reject"),
                                            onPressed: () {
                                              // your code
                                            }),
                                        RaisedButton(
                                            child: Text("Accept"),
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
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                color: Color(0xFFF40c1c),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: CircleAvatar(
                            radius: 40.0,
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 70.0,
                            ),
                            backgroundColor: Colors.pinkAccent,
                          ),
                        ),
                        Text(
                          "Welcome",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          'person name',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.cancel_outlined),
                title: Text('Rejected Orders'),
                onTap: () {
                  Navigator.of(context)
                      .push(
                      MaterialPageRoute(
                          builder: (context) => rejectedorders()
                      )
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.check_circle_outline),
                title: Text('Completed Orders'),
                onTap: () {
                  Navigator.of(context)
                      .push(
                      MaterialPageRoute(
                          builder: (context) => completedorders()
                      )
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.text_snippet_outlined),
                title: Text('Services'),
                onTap: () {
                  Navigator.of(context)
                      .push(
                      MaterialPageRoute(
                          builder: (context) => services()
                      )
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.star_border_outlined),
                title: Text('Rate Us'),
                /*onTap: () {
                  Navigator.of(context)
                      .push(
                      MaterialPageRoute(
                          builder: (context) => edit_profile()
                      )
                  );
                },*/
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
                /*onTap: () {
                  Navigator.of(context)
                      .push(
                      MaterialPageRoute(
                          builder: (context) => edit_profile()
                      )
                  );
                },*/
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Contact Us'),
                onTap: () {
                  Navigator.of(context)
                      .push(
                      MaterialPageRoute(
                          builder: (context) => contactus()
                      )
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.power_settings_new),
                title: Text('Logout'),
                /*onTap: () {
                  Navigator.of(context)
                      .push(
                      MaterialPageRoute(
                          builder: (context) => edit_profile()
                      )
                  );
                },*/
              ),
            ],
          ),
        ),
      ),
    );
  }
}
