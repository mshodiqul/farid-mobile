import 'package:flutter/material.dart';

class OrganisasiList extends StatefulWidget {
  final String nim;

  OrganisasiList({
    @required this.nim
  });

  @override
  _PrestasiNonAkademikState createState() => _PrestasiNonAkademikState();
}

class _PrestasiNonAkademikState extends State<OrganisasiList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Organisasi Dari Mahasiswa'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Riwayat Organisasi Dari Mahasiswa', style: TextStyle(
                fontSize: 25.0,
                color: Theme.of(context).primaryColor
              )),
              SizedBox(height: 10.0),
              Text('Nama Mahasiswa : Farid'),
              SizedBox(height: 5.0),
              Text('Nim : 201809820109'),
              SizedBox(height: 30.0),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 250,
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (_, int index) {
                    return ListTile(
                      title: Text('Mahasiswa Aktif Indonesia'),
                      subtitle: Text('2016 - 2017'),
                      trailing: Text('Anggota', style: TextStyle(
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