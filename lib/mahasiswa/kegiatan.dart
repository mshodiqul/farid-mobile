import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api.dart' show urlApi;
import 'package:http/http.dart' as http;

class MahasiswaKegiatan extends StatefulWidget {
  @override
  _PrestasiNonAkademikState createState() => _PrestasiNonAkademikState();
}

class _PrestasiNonAkademikState extends State<MahasiswaKegiatan> {
  List data = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userIdU = preferences.getString('userid');

    http.Response response = await http.get(urlApi + '/api/kegiatan/apply-list.php?nim=${userIdU}');
    var body = jsonDecode(response.body);
    setState(() {
      data = body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kegiatan Yang Anda Ikuti'),
      ),
      floatingActionButton: FloatingActionButton(
        child : Icon(Icons.add_box),
        onPressed: () {
          Navigator.pushNamed(context, '/mahasiswa/kegiatan/list');
        }
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, int index) {
          Map<dynamic, dynamic> d = data[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text((index + 1).toString()),
            ),
            title: Text(d['judul']),
            subtitle: Text(d['tanggal']),
          );
        },
      )
    );
  }
}