import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api.dart' show urlApi;
import 'package:http/http.dart' as http;

class MahasiswaKegiatanTambah extends StatefulWidget {
  final String idKegiatan;
  final String namaKegiatan;

  MahasiswaKegiatanTambah(this.idKegiatan, this.namaKegiatan);

  @override
  _MahasiswaKegiatanTambahState createState() => _MahasiswaKegiatanTambahState();
}

class _MahasiswaKegiatanTambahState extends State<MahasiswaKegiatanTambah> {
  String _pathSurat = '';
  File fileSurat;
  File fileDokumentasi;
  Map data = {};

  final _formKey = GlobalKey<FormState>();
  selectSurat() async {
    try {
      _pathSurat = await FilePicker.getFilePath(type: FileType.ANY);
      setState(() {
        fileSurat = new File(_pathSurat);
      });
    } catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getData() async {
    http.Response response = await http.get(urlApi + '/api/kegiatan/list.php');
    var body = jsonDecode(response.body);
    setState(() {
      data = body[0];
    });
    print(data);
  }

  onSubmit() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userIdU = preferences.getString('userid');

    Map<String, dynamic> dataToSend = {
      'nim' : userIdU,
      'id_kegiatan' : widget.idKegiatan,
      'surat_base64' : base64Encode(fileSurat.readAsBytesSync()),
      'surat_ext' : _pathSurat.split('.').last
    };

    http.Response response = await http.post(urlApi + '/api/kegiatan/apply.php', body: dataToSend);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Success'),
        content: Text('Berhasil Mengikuti Kegiatan'),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context).pop();
            },
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ikuti Kegiatan'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Nama Kegiatan'),
                Text(widget.namaKegiatan, style: TextStyle(
                  fontSize: 20.0
                )),
                SizedBox(height: 20.0),
                Text('Waktu Pelaksanaan'),
                Text(data['Waktu Pelaksanaan'], style: TextStyle(
                  fontSize: 20.0
                )),
                SizedBox(height: 20.0),
                Text('Tanggal'),
                Text(data['tanggal'], style: TextStyle(
                  fontSize: 20.0
                )),
                SizedBox(height: 20.0),
                Text('Waktu'),
                Text(data['pukul'] != '' ? data['pukul'] : '-', style: TextStyle(
                  fontSize: 20.0
                )),
                SizedBox(height: 20.0),
                Text('Tempat'),
                Text(data['tempat'] != null ? data['tempat'] : '-', style: TextStyle(
                  fontSize: 20.0
                )),
                SizedBox(height: 20.0),
                Text('Untuk Mengikuti Kegiatan Ini Kamu Harus Upload Sertifikat Kamu'),
                SizedBox(height: 10.0),
                FlatButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text('Upload Sertifikat'),
                  onPressed: selectSurat,
                ),
                _pathSurat.isNotEmpty == true ? Text(_pathSurat, style: TextStyle(
                  fontSize: 10.0
                )) : Text('File belum di pilih'),
                SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    child: Text('Ikuti Kegiatan Ini'),
                    onPressed: onSubmit,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}