import 'package:flutter/material.dart';

class DrawerStaff extends StatelessWidget {
  final String nama;
  final String userId;
  DrawerStaff({
    @required this.nama,
    @required this.userId
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
                    Text(userId, style: TextStyle(
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
        ListTile(
          title: Text('Profile'),
          leading: Icon(Icons.person),
          onTap: () {
            Navigator.of(context).pushNamed('/user');
          },
        ),
        ListTile(
          title: Text('Mahasiswa'),
          leading: Icon(Icons.group),
          onTap: () {
            Navigator.of(context).pushNamed('/mahasiswa');
          },
        ),
        ListTile(
          title: Text('Kegiatan'),
          leading: Icon(Icons.calendar_today),
          onTap: () {
            Navigator.of(context).pushNamed('/kegiatan');
          },
        ),
        ListTile(
          title: Text('Akademik'),
          leading: Icon(Icons.star),
          onTap: () {
            Navigator.of(context).pushNamed('/prestasi-akademik');
          },
        ),
        ListTile(
          title: Text('Non Akademik'),
          leading: Icon(Icons.filter),
          onTap: () {
            Navigator.of(context).pushNamed('/prestasi-non-akademik');
          },
        ),
        ListTile(
          title: Text('Organisasi'),
          leading: Icon(Icons.group_work),
          onTap: () {
            Navigator.of(context).pushNamed('/organisasi');
          },
        ),
        ListTile(
          title: Text('Karya Tulis'),
          leading: Icon(Icons.book),
          onTap: () {
            Navigator.of(context).pushNamed('/karya-tulis');
          },
        ),
        ListTile(
          title: Text('Non Akademik'),
          leading: Icon(Icons.attach_money),
          onTap: () {
            Navigator.of(context).pushNamed('/pengajuan-dana');
          },
        ),
        ListTile(
          title: Text('Laporan Semester'),
          leading: Icon(Icons.collections_bookmark),
          onTap: () {
            Navigator.of(context).pushNamed('/laporan-semester');
          },
        )
      ],
    );
  }
}