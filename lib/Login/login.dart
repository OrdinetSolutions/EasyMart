import 'dart:convert';

import '../main.dart';
import 'file:///E:/Flutter/ecom_admin/lib/Categorypages/category.dart';
import 'package:ecom_admin/Login/crudLogin.dart';
import 'package:ecom_admin/Main/pendingrequest.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {

  final TextEditingController usernameController =
  TextEditingController(); //calliing the method from service folder

  final TextEditingController passwordController =
  TextEditingController(); //calliing the method from service folder

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Login"),
          backgroundColor: Color(0xFFF40c1c),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: Wrap(
            children: [
              SizedBox(height: 100.0),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 5.0, right: 20.0, bottom: 5.0),
                child: TextFormField(
                  controller: usernameController,
                  validator: (val) =>
                  (val.length == 0 ? 'This field is required' : null),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    labelText: 'Enter your Username',
                    focusColor: Colors.black,
                    //contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 5.0, right: 20.0, bottom: 5.0),
                child: TextFormField(
                  controller: passwordController,
                  validator: (val) =>
                  (val.length == 0 ? 'This field is required' : null),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    labelText: 'Enter your password',
                    focusColor: Colors.black,
                    //contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: RaisedButton(
                  onPressed: () async {
                    final String username = usernameController.text;
                    final String password = passwordController.text;

                    final String url =
                        "http://192.168.43.82/Eassymart/VersionCode1/Admin/checkAdminLogin.php";
                    List data;

                    var response = await http.post(
                        url,
                        body: {
                          "username": username,
                          "password": password
                        },
                        headers: {"Accept": "application/json"});
                    print(response.body);
                    setState(() {
                      var convertDataTojson = jsonDecode(response.body.toString());
                      if(convertDataTojson == 0)
                        {
                          print("Invalid Username/Password");
                        }else{
                          data = convertDataTojson['admin'];
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                          print(data);
                        }

                    });

                  },

                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFFF40c1c),
                          //Color(0xFF1976D2),
                          Color(0xFFF40c1c),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: const Text('          Login         ',
                        style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
