import 'package:flutter/material.dart';

class KaryaTulisList extends StatefulWidget {
  final String nim;

  KaryaTulisList({
    @required this.nim
  });

  @override
  _KaryaTulisListState createState() => _KaryaTulisListState();
}

class _KaryaTulisListState extends State<KaryaTulisList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Karya Tulis Mahasiswa'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Karya Tulis Dari Mahasiswa', style: TextStyle(
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
                      title: Text('Contoh Karya Tulis Yang Saya Buat'),
                      subtitle: Text('Teknologi Informasi'),
                      trailing: FlatButton.icon(
                        color: Theme.of(context).primaryColor,
                        icon: Icon(Icons.attach_file, size: 16.0),
                        textColor: Colors.white,
                        onPressed: () {

                        },
                        label: Text('Berkas', style: TextStyle(
                          fontSize: 10.0
                        )),
                      ),
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