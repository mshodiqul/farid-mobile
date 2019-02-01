import 'package:flutter/material.dart';

class MahasiswaOrganisasi extends StatefulWidget {
  @override
  _MahasiswaOrganisasiState createState() => _MahasiswaOrganisasiState();
}

class _MahasiswaOrganisasiState extends State<MahasiswaOrganisasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Organisasi'),
      ),
      floatingActionButton: FloatingActionButton(
        child : Icon(Icons.add_box),
        onPressed: () {
          // Navigator.pushNamed(context, '/mahasiswa/prestasi-non-akademik/add');
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
            title: Text('Data Contoh Riwayat Organisasi'),
            subtitle: Text('2018 - 2019'),
            trailing: Text('Ketua', style: TextStyle(
              color: Theme.of(context).primaryColor
            )),
          );
        },
      )
    );
  }
}