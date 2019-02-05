import 'dart:convert';
import 'package:flutter/material.dart';
import './config/api.dart' show urlApi;
import 'package:http/http.dart' as http;

class Kegiatan extends StatefulWidget {
  _KegiatanState createState() => _KegiatanState();
}

class _KegiatanState extends State<Kegiatan> {
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
    http.Response response = await http.get(urlApi + '/api/kegiatan/list.php');
    var body = jsonDecode(response.body);
    setState(() {
      data = body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Kegiatan'),
      ),
      floatingActionButton: FloatingActionButton(
        child : Icon(Icons.add_box),
        onPressed: () {
          Navigator.pushNamed(context, '/kegiatan/tambah');
        }
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, int index) {
          Map<String, dynamic> kegiatan = data[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text((index + 1).toString()),
            ),
            title: Text(kegiatan['Judul Kegiatan']),
            subtitle: Text('${kegiatan['Waktu Pelaksanaan']} - ${kegiatan['tanggal']} ${kegiatan['pukul']}'),
          );
        },
      )
    );
  }
}