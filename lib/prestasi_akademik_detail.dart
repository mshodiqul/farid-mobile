import 'package:flutter/material.dart';

class PrestasiAkademikDetail extends StatefulWidget {
  final String id;
  PrestasiAkademikDetail({
    @required this.id
  });

  _PrestasiAkademikDetailState createState() => _PrestasiAkademikDetailState();
}

class _PrestasiAkademikDetailState extends State<PrestasiAkademikDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Prestasi Akademik'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Prestasi Akademik Dari Nama Mahasiswa', style: TextStyle(
                fontSize: 25.0,
                color: Theme.of(context).primaryColor
              )),
              SizedBox(height: 40.0),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text('A')
                ),
                title: Text('Semester 1'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text('A')
                ),
                title: Text('Semester 2'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text('A')
                ),
                title: Text('Semester 3'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text('A')
                ),
                title: Text('Semester 4'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text('A')
                ),
                title: Text('Semester 5'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text('A')
                ),
                title: Text('Semester 6'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text('A')
                ),
                title: Text('Semester 7'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text('A')
                ),
                title: Text('Semester 8'),
              ),
            ],
          ),
        ),
      )
    );
  }
}