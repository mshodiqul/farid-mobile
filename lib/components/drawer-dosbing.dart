import 'package:flutter/material.dart';

class DrawerDosbing extends StatelessWidget {
  final String nama;
  final String userId;
  DrawerDosbing({
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
          title: Text('Persetujuan Prestasi'),
          leading: Icon(Icons.person),
          onTap: () {
            Navigator.of(context).pushNamed('/user');
          },
        ),
      ],
    );
  }
}