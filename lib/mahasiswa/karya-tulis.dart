import 'package:flutter/material.dart';

class KaryaTulis extends StatefulWidget {
  _KegiatanState createState() => _KegiatanState();
}

class _KegiatanState extends State<KaryaTulis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Karya Tulis'),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (_, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text((index + 1).toString()),
            ),
            title: Text('Karya Tulis Ke ${index + 1}'),
            subtitle: Text('Teknologi Informasi'),
          );
        },
      )
    );
  }
}