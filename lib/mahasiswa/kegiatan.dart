import 'package:flutter/material.dart';

class MahasiswaKegiatan extends StatefulWidget {
  @override
  _PrestasiNonAkademikState createState() => _PrestasiNonAkademikState();
}

class _PrestasiNonAkademikState extends State<MahasiswaKegiatan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kegiatan Yang Anda Ikuti'),
      ),
      floatingActionButton: FloatingActionButton(
        child : Icon(Icons.add_box),
        onPressed: () {
          // Navigator.pushNamed(context, '/mahasiswa/kegiatan/add');
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Coming Soon'),
              content: Text('Halaman Sedang Dalam Perbaikan'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                )
              ],
            )
          );
        }
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (_, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text((index + 1).toString()),
            ),
            title: Text('Contoh Kegiatan Anda'),
            subtitle: Text('08 April 2019'),
          );
        },
      )
    );
  }
}