import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../config/api.dart' show urlApi;

class KaryaTulis extends StatefulWidget {
  _KegiatanState createState() => _KegiatanState();
}

class _KegiatanState extends State<KaryaTulis> {
  bool loading = false;
  List data = [];
  String userId = '';

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
    setState(() {
      loading = true;
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('userid');
    print(userId);

    http.Response response = await http.get(urlApi + '/api/karya-tulis/list.php?nim=' + userId);
    var body = jsonDecode(response.body);
    setState(() {
      data = body;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Karya Tulis'),
      ),
      floatingActionButton: FloatingActionButton(
        child : Icon(Icons.add_box),
        onPressed: () {
          Navigator.pushNamed(context, '/mahasiswa/karya-tulis/tambah');
        }
      ),
      body: loading ? Center(
          child: SizedBox(
            width: 100.0,
            height: 100.0,
            child: CircularProgressIndicator(),
          ),
        ) : ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, int index) {
          Map<String, dynamic> kt = data[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text((index + 1).toString()),
            ),
            title: Text(kt['Judul']),
            subtitle: Text(kt['Bidang']),
          );
        },
      )
    );
  }
}