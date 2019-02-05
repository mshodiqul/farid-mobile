import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './config/api.dart' show urlApi;
import './prestasi_akademik_detail.dart';

class PrestasiAkademik extends StatefulWidget {
  _PrestasiAkademikState createState() => _PrestasiAkademikState();
}

class _PrestasiAkademikState extends State<PrestasiAkademik> {
  List data = [];
  bool loading = false;
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
    setState(() {
      loading = true;
    });
    http.Response response = await http.get(urlApi + '/api/mahasiswa/list.php');
    var body = jsonDecode(response.body);
    await Future.delayed(Duration(
      seconds: 1
    ));
    setState(() {
      data = body;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Prestasi Mahasiswa'),
      ),
      body: loading ? Center(
          child: SizedBox(
            width: 100.0,
            height: 100.0,
            child: CircularProgressIndicator(),
          ),
        ) : ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        itemCount: data.length,
        itemBuilder: (_, int index) {
          Map<String, dynamic> mahasiswa = data[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text((index+1).toString()),
            ),
            title: Text('${mahasiswa['nama']}'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => new PrestasiAkademikDetail(id: mahasiswa['nim'])
              ));
            },
          );
        },
      )
    );
  }
}