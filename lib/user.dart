import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './config/api.dart' show urlApi;

class UserApp extends StatefulWidget {
  UserAppState createState() => UserAppState();
}

class UserAppState extends State<UserApp> {
  List data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getData() async {
    http.Response response = await http.get(urlApi + '/api/users/list.php');
    var body = jsonDecode(response.body);
    setState(() {
      data = body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelolah User'),
      ),
      floatingActionButton: FloatingActionButton(
        child : Icon(Icons.add_box),
        onPressed: () {
          Navigator.pushNamed(context, '/add-user');
        }
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Pencarian Berdasarkan Nama',
                          border: OutlineInputBorder()
                        ),
                        textInputAction: TextInputAction.search,
                        onFieldSubmitted: (String value) {
                          print(value);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 100.0,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, int index) {
                  Map<String, dynamic> user = data[index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text('${user['nama_user']}'.substring(0,1)),
                    ),
                    onTap: () {

                    },
                    title: Text('${user['nama_user']}'),
                    subtitle: Text('${user['user_id']}'),
                    trailing: Container(
                      padding: EdgeInsets.all(10.0),
                      color: Theme.of(context).primaryColor,
                      child: Text('${user['role']}', style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0
                      )),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}