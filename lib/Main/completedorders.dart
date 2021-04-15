import 'package:flutter/material.dart';

class completedorders extends StatefulWidget {
  @override
  _completedordersState createState() => _completedordersState();
}

class _completedordersState extends State<completedorders> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Completed Orders"),
          backgroundColor: Color(0xFFF40c1c),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
      ),
    );
  }
}
