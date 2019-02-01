import 'package:flutter/material.dart';

class MahasiswaPrestasiNonAkademik extends StatefulWidget {
  @override
  _PrestasiNonAkademikState createState() => _PrestasiNonAkademikState();
}

class _PrestasiNonAkademikState extends State<MahasiswaPrestasiNonAkademik> {
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
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (_, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text((index + 1).toString()),
            ),
            title: Text('Prestasi Kegiatan Anda'),
            subtitle: Text('Tingkat : Kabupaten'),
          );
        },
      )
    );
  }
}