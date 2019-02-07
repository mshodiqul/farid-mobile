import 'dart:convert';

import '../config/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PersetujuanDetail extends StatefulWidget {
  final String id;
  PersetujuanDetail({
    @required this.id
  });

  _PersetujuanDetailState createState() => _PersetujuanDetailState();
}

class _PersetujuanDetailState extends State<PersetujuanDetail> {
  bool loading = false;
  Map<String, dynamic> data = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getData() async {
    setState(() {
      loading = true;
    });

    http.Response response = await http.get(urlApi + '/api/prestasi-akademik/list.php?nim=' + widget.id);
    var body = jsonDecode(response.body);
    setState(() {
      data = body.length > 0 ? body[0] : {
        'Nilai_Semester1' : '0',
        'Nilai_Semester2' : '0',
        'Nilai_Semester3' : '0',
        'Nilai_Semester4' : '0',
        'Nilai_Semester5' : '0',
        'Nilai_Semester6' : '0',
        'Nilai_Semester7' : '0',
        'Nilai_Semester8' : '0',
      };
      loading = false;
    });
  }

  terimaPengajuan() async {
    Navigator.of(context, rootNavigator: true).pop();

    setState(() {
      loading = true;
    });

    Map<String, dynamic> dataToSend = {
      'status' : 'diterima',
      'id' : data['id_prestasi_akademik']
    };

    http.Response response = await http.post(urlApi + '/api/prestasi-akademik/confirmasi.php', body: dataToSend);
    setState(() {
      loading = false;
    });
    Navigator.of(context).pop();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Prestasi Akademik'),
      ),
      persistentFooterButtons: data['status'] == 'pending' ? <Widget>[
        FlatButton(
          textColor: Colors.red,
          child: Text('Tolak'),
          onPressed: () {
            
          },
        ),
        FlatButton(
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          child: Text('Terima'),
          onPressed: () {
            return showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('Konfirmasi'),
                content: Text('Apakah Anda Yakin Ingin Menerima Nilai Prestasi Siswa Ini ?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Terima'),
                    onPressed: terimaPengajuan,
                  ),
                  FlatButton(
                    child: Text('Tidak'),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  )
                ],
              )
            );
          },
        ),
      ] : [],
      body: loading ? Center(
          child: SizedBox(
            width: 100.0,
            height: 100.0,
            child: CircularProgressIndicator(),
          ),
        ) : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Prestasi Akademik Dari Mahasiswa', style: TextStyle(
                fontSize: 25.0,
                color: Theme.of(context).primaryColor
              )),
              SizedBox(height: 40.0),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  child: Text(data['Nilai_Semester1'])
                ),
                title: Text('Semester 1'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  child: Text(data['Nilai_Semester2'])
                ),
                title: Text('Semester 2'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  child: Text(data['Nilai_Semester3'])
                ),
                title: Text('Semester 3'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  child: Text(data['Nilai_Semester4'])
                ),
                title: Text('Semester 4'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  child: Text(data['Nilai_Semester5'])
                ),
                title: Text('Semester 5'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  child: Text(data['Nilai_Semester6'])
                ),
                title: Text('Semester 6'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  child: Text(data['Nilai_Semester7'])
                ),
                title: Text('Semester 7'),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  child: Text(data['Nilai_Semester8'])
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