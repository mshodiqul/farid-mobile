import 'dart:convert';
import 'package:flutter/material.dart';
import '../config/api.dart' show urlApi;
import 'package:http/http.dart' as http;
import './kegiatan-tambah.dart';

class MahasiswaKegiatanList extends StatefulWidget {
  @override
  _PrestasiNonAkademikState createState() => _PrestasiNonAkademikState();
}

class _PrestasiNonAkademikState extends State<MahasiswaKegiatanList> {
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
    print(body);
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
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, int index) {
          Map<String, dynamic> kegiatan = data[index];

          return ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => MahasiswaKegiatanTambah(kegiatan['id_kegiatan'], kegiatan['Judul Kegiatan'])
              )).then((value) {
                print(value);
              });
            },
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text((index + 1).toString()),
            ),
            title: Text(kegiatan['Judul Kegiatan']),
            trailing: Text(kegiatan['mhs'] + ' Mhs'),
            subtitle: Text('${kegiatan['Waktu Pelaksanaan']} - ${kegiatan['tanggal']} ${kegiatan['pukul']}'),
          );
        },
      )
    );
  }
}