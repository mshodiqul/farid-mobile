import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import './config/api.dart' show urlApi;
import './karya-tulis-list.dart';

class KaryaTulisApp extends StatefulWidget {
  _KaryaTulisState createState() => _KaryaTulisState();
}

class _KaryaTulisState extends State<KaryaTulisApp> {
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
        title: Text('Daftar Karya Tulis'),
      ),
      body: loading ? Center(
          child: SizedBox(
            width: 100.0,
            height: 100.0,
            child: CircularProgressIndicator(),
          ),
        ) : SingleChildScrollView(
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
                  Map<String, dynamic> d = data[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(d['nama'].substring(0,1)),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => KaryaTulisList(nim: d['nim'], nama: d['nama'])
                      ));
                    },
                    title: Text(d['nama']),
                    subtitle: Text('NIM : ${d['nim']}')
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