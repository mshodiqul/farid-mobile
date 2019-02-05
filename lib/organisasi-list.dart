import 'dart:convert';

import 'package:flutter/material.dart';
import './config/api.dart';
import 'package:http/http.dart' as http;
import './organisasi-detail.dart';

class OrganisasiList extends StatefulWidget {
  final String nim;
  final String nama;

  OrganisasiList({
    @required this.nim,
    @required this.nama
  });

  @override
  _PrestasiNonAkademikState createState() => _PrestasiNonAkademikState();
}

class _PrestasiNonAkademikState extends State<OrganisasiList> {
  bool loading = false;
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
    setState(() {
      loading = true;
    });

    http.Response response = await http.get(urlApi + '/api/organisasi/list.php?nim=' + widget.nim);
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
        title: Text('Daftar Organisasi Dari Mahasiswa'),
      ),
      body: loading ? Center(
          child: SizedBox(
            width: 100.0,
            height: 100.0,
            child: CircularProgressIndicator(),
          ),
        ) : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: data.length <= 0 ? Center(
            child: Text('Belum Ada Organisasi Yang Di Ikuti Oleh ${widget.nama}'),
          ) : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Riwayat Organisasi Dari Mahasiswa', style: TextStyle(
                fontSize: 25.0,
                color: Theme.of(context).primaryColor
              )),
              SizedBox(height: 10.0),
              Text('Nama Mahasiswa : ${widget.nama}'),
              SizedBox(height: 5.0),
              Text('Nim : ${widget.nim}'),
              SizedBox(height: 30.0),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 250,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (_, int index) {
                    Map<String, dynamic> d = data[index];

                    return ListTile(
                      title: Text(d['Nama Organisasi']),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => OrganisasiDetail(id: d['id_riwayatorganisasi'])
                        ));
                      },
                      subtitle: Text('${d['Mulai Aktif']} - ${d['Akhir Keaktifan']}'),
                      trailing: Text(d['Jabatan'], style: TextStyle(
                        color: Theme.of(context).primaryColor
                      )),
                    );
                  },
                ),
              )
            ]
          )
        )
      )
    );
  }
}