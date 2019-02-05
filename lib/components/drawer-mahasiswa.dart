import 'package:flutter/material.dart';

class DrawerMahasiswa extends StatelessWidget {
  final String nama;
  final String nim;
  DrawerMahasiswa({
    @required this.nama,
    @required this.nim
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.white,
                  child: Text('F', style: TextStyle(
                    fontSize: 40.0
                  )),
                ),
                SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(nama, style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold
                    )),
                    Text(nim, style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0
                    )),
                  ],
                )
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor
          ),
        ),

        ListTile(
          title: Text('Home'),
          leading: Icon(Icons.home),
          onTap: () {
            Navigator.of(context).pushNamed('/');
          },
        ),
        Divider(),
        ListTile(
          title: Text('Profile'),
          leading: Icon(Icons.person),
          onTap: () {
            Navigator.of(context).pushNamed('/mahasiswa/user');
          },
        ),
        Divider(),
        ListTile(
          title: Text('Mahasiswa'),
          leading: Icon(Icons.group),
          onTap: () {
            Navigator.of(context).pushNamed('/mahasiswa/data');
          },
        ),
        Divider(),
        ListTile(
          title: Text('Kegiatan'),
          leading: Icon(Icons.calendar_today),
          onTap: () {
            Navigator.of(context).pushNamed('/mahasiswa/kegiatan');
          },
        ),
        Divider(),
        ListTile(
          title: Text('Akademik'),
          leading: Icon(Icons.star),
          onTap: () {
            Navigator.of(context).pushNamed('/mahasiswa/prestasi-akademik');
          },
        ),
        Divider(),
        ListTile(
          title: Text('Non Akademik'),
          leading: Icon(Icons.filter),
          onTap: () {
            Navigator.of(context).pushNamed('/mahasiswa/prestasi-non-akademik');
          },
        ),
        ListTile(
          title: Text('Organisasi'),
          leading: Icon(Icons.group_work),
          onTap: () {
            Navigator.of(context).pushNamed('/mahasiswa/organisasi');
          },
        ),
        ListTile(
          title: Text('Karya Tulis'),
          leading: Icon(Icons.book),
          onTap: () {
            Navigator.of(context).pushNamed('/mahasiswa/karya-tulis');
          },
        ),
        ListTile(
          title: Text('Non Akademik'),
          leading: Icon(Icons.attach_money),
          onTap: () {
            Navigator.of(context).pushNamed('/mahasiswa/pengajuan-dana');
          },
        ),
        ListTile(
          title: Text('Laporan Semester'),
          leading: Icon(Icons.collections_bookmark),
          onTap: () {
            Navigator.of(context).pushNamed('/mahasiswa/laporan-semester');
          },
        )
      ],
    );
  }
}