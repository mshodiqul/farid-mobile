import 'package:flutter/material.dart';

class PrestasiNonAkademikDetail extends StatefulWidget {
  final String nim;

  PrestasiNonAkademikDetail({
    @required this.nim
  });

  @override
  _PrestasiNonAkademikState createState() => _PrestasiNonAkademikState();
}

class _PrestasiNonAkademikState extends State<PrestasiNonAkademikDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Prestasi No Akademik'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Prestasi Non Akademik Dari Nama Mahasiswa', style: TextStyle(
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
                      title: Text('Contoh Prestasi'),
                      subtitle: Text('Tingkat Provinsi'),
                      trailing: Text('Juara 1', style: TextStyle(
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