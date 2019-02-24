import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/api.dart' show urlApi;
import 'package:shared_preferences/shared_preferences.dart';
import './prestasi-non-akademik-detail.dart';

class MahasiswaPrestasiNonAkademik extends StatefulWidget {
  @override
  _PrestasiNonAkademikState createState() => _PrestasiNonAkademikState();
}

class _PrestasiNonAkademikState extends State<MahasiswaPrestasiNonAkademik> {
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

    http.Response response = await http.get(urlApi + '/api/prestasi-non-akademik/list.php?nim=' + userId);
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
        title: Text('Daftar Prestasi Non Akademik'),
      ),
      floatingActionButton: FloatingActionButton(
        child : Icon(Icons.add_box),
        onPressed: () {
          Navigator.pushNamed(context, '/mahasiswa/prestasi-non-akademik/add');
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
          var prestasi = data[index];

          return ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => PrestasiNonAkademikDetailMhs(id: prestasi['id_prestasi_non_akademik'])
              ));
            },
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text((index + 1).toString()),
            ),
            title: Text(prestasi['Kegiatan']),
            subtitle: Text('Tingkat : ${prestasi['Tingkat']}'),
            trailing: Text(prestasi['Hasil'], style: TextStyle(
              color: Theme.of(context).primaryColor
            )),
          );
        },
      )
    );
  }
}