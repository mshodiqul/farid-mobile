import 'dart:convert';

import 'package:flutter/material.dart';
import '../detail-mahasiswa.dart';
import '../config/api.dart' show urlApi;
import 'package:http/http.dart' as http;

class DataMahasiswa extends StatefulWidget {
  MahasiswaAppState createState() => MahasiswaAppState();
}

class MahasiswaAppState extends State<DataMahasiswa> {
  List data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  void dispose() {
    super.dispose();
  }

  getData() async {
    http.Response response = await http.get(urlApi + '/api/mahasiswa/list.php');
    var body = jsonDecode(response.body);
    setState(() {
      data = body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Mahasiswa'),
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
                  Map<String, dynamic> mahasiswa = data[index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(mahasiswa['nama'].substring(0,1)),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => DetailMahasiswa(nim: mahasiswa['nim'])
                      ));
                    },
                    title: Text("${mahasiswa['nama']} - ${mahasiswa['nim']}"),
                    subtitle: Text('${mahasiswa['program_studi']}')
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