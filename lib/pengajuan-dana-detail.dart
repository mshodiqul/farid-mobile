import 'dart:convert';
import 'dart:io';

import './config/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class PengajuanDanaDetail extends StatefulWidget {
  final String id;
  PengajuanDanaDetail({
    @required this.id
  });

  @override
  _PengajuanDanaDetailState createState() => _PengajuanDanaDetailState();
}

class _PengajuanDanaDetailState extends State<PengajuanDanaDetail> {
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

    http.Response response = await http.get(urlApi + '/api/pengajuan-dana/list.php?id=' + widget.id + '&join=true');
    
    var body = jsonDecode(response.body);
    print(body);
    setState(() {
      data = body.length > 0 ? body[0] : {};
      loading = false;
    });
  }

  Future<File> _downloadFile(String url, String filename) async {
      http.Client _client = new http.Client();
      var req = await _client.get(Uri.parse(url));
      var bytes = req.bodyBytes;
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = new File('$dir/$filename');
      await file.writeAsBytes(bytes);
      return file;
  }

  terimaPengajuan() async {
    Navigator.of(context, rootNavigator: true).pop();

    setState(() {
      loading = true;
    });

    Map<String, dynamic> dataToSend = {
      'status' : 'diterima',
      'id' : widget.id
    };

    http.Response response = await http.post(urlApi + '/api/pengajuan-dana/confirmasi.php', body: dataToSend);
    setState(() {
      loading = false;
    });
    getData();
  }

  tolakPengajuan() async {
    Navigator.of(context, rootNavigator: true).pop();

    setState(() {
      loading = true;
    });

    Map<String, dynamic> dataToSend = {
      'status' : 'ditolak',
      'id' : widget.id
    };

    http.Response response = await http.post(urlApi + '/api/pengajuan-dana/confirmasi.php', body: dataToSend);
    setState(() {
      loading = false;
    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengajuan Dana Detail'),
      ),
      persistentFooterButtons: data['status'] == 'pending' ? <Widget>[
        FlatButton(
          textColor: Colors.red,
          child: Text('Tolak'),
          onPressed: () {
            return showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('Konfirmasi'),
                content: Text('Apakah Anda Yakin Ingin Menolak Pengajuan Ini ?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('YA, TOLAK SAJA'),
                    onPressed: tolakPengajuan,
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
        FlatButton(
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          child: Text('Terima'),
          onPressed: () {
            return showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('Konfirmasi'),
                content: Text('Apakah Anda Yakin Ingin Menerima Pengajuan Ini ?'),
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
              Text('Pengajuan Dana Dari Mahasiswa', style: TextStyle(
                fontSize: 25.0,
                color: Theme.of(context).primaryColor
              )),
              SizedBox(height: 40.0),
              Text('Nama Mahasiswa', style: TextStyle(
                fontSize: 18.0,
                color: Theme.of(context).primaryColor
              )),
              SizedBox(height: 10.0),
              Text(data['nama']),
              SizedBox(height: 20.0),
              Text('Nomor Induk Mahasiswa', style: TextStyle(
                fontSize: 18.0,
                color: Theme.of(context).primaryColor
              )),
              SizedBox(height: 10.0),
              Text(data['nim']),
              SizedBox(height: 20.0),
              Text('Keperluan', style: TextStyle(
                fontSize: 18.0,
                color: Theme.of(context).primaryColor
              )),
              SizedBox(height: 10.0),
              Text(data['Keperluan']),
              SizedBox(height: 20.0),
              Text('Total', style: TextStyle(
                fontSize: 18.0,
                color: Theme.of(context).primaryColor
              )),
              SizedBox(height: 10.0),
              Text('Rp ${data['Volume']}'),
              SizedBox(height: 20.0),
              FlatButton.icon(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                icon: Icon(Icons.attachment),
                label: Text('Nota'),
                onPressed: () async {
                  File file = await _downloadFile(urlApi + '/files/' + data['Nota'], data['Nota']);
                  OpenFile.open(file.path);
                },
              )
            ]
          )
        )
      )
    );
  }
}