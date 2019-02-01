import 'package:flutter/material.dart';

class MahasiswaPengajuanDana extends StatefulWidget {
  @override
  _PengajuanDanaState createState() => _PengajuanDanaState();
}

class _PengajuanDanaState extends State<MahasiswaPengajuanDana> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pengajuan Dana'),
      ),
      floatingActionButton: FloatingActionButton(
        child : Icon(Icons.add_box),
        onPressed: () {
          Navigator.pushNamed(context, '/mahasiswa/pengajuan-dana/add');
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
            title: Text('Acara Black Friday'),
            subtitle: Text('Rp 20,000,000'),
            trailing: Text('Pending', style: TextStyle(
              color: Colors.yellow.shade800
            )),
          );
        },
      )
    );
  }
}