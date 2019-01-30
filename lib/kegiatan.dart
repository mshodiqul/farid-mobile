import 'package:flutter/material.dart';

class Kegiatan extends StatefulWidget {
  _KegiatanState createState() => _KegiatanState();
}

class _KegiatanState extends State<Kegiatan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Kegiatan'),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (_, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text(index.toString()),
            ),
            title: Text('Event ${index}'),
            subtitle: Text('Waktu Pelaksana : 2019-08-20'),
          );
        },
      )
    );
  }
}