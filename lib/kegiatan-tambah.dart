import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import './config/api.dart' show urlApi;
import 'package:http/http.dart' as http;

class KegiatanTambah extends StatefulWidget {
  @override
  _KegiatanTambahState createState() => _KegiatanTambahState();
}

class _KegiatanTambahState extends State<KegiatanTambah> {
  TextEditingController judul = TextEditingController();
  TextEditingController jam = TextEditingController();
  TextEditingController waktu = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  TextEditingController pukul = TextEditingController();
  TextEditingController pelaksana = TextEditingController();

  String _pathSurat = '';
  String _pathDokumentasi = '';
  bool loading = false;

  File fileSurat;
  File fileDokumentasi;

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

  selectDokumentasi() async {
    try {
      _pathDokumentasi = await FilePicker.getFilePath(type: FileType.ANY);
      setState(() {
        fileDokumentasi = new File(_pathDokumentasi);
      });
    } catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  submitKegiatan() async {
    if (_formKey.currentState.validate()) {

      Map<String, dynamic> dataToSend = {
        'judul' : judul.text,
        'waktu' : waktu.text,
        'pelaksana' : pelaksana.text,
        'surat_base64' : base64Encode(fileSurat.readAsBytesSync()),
        'surat_ext' : _pathSurat.split('.').last,
        'dokumentasi_base64' : base64Encode(fileDokumentasi.readAsBytesSync()),
        'dokumentasi_ext' : _pathDokumentasi.split('.').last,
        'tanggal' : tanggal.text,
        'pukul' : jam.text
      };
      http.Response response = await http.post(urlApi + '/api/kegiatan/tambah.php', body: dataToSend);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Success'),
          content: Text('Berhasil Tambah Kegiatan'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key:_formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Nama Kegiatan"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Nama Kegiatan'
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Nama Kegiatan tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: judul,
                ),
                SizedBox(height: 20.0),
                Text("Tanggal"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Tanggal',
                  ),
                  controller: tanggal,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Tanggal tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                Text("Jam"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Jam',
                  ),
                  controller: jam,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Pukul tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                Text("Waktu"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Waktu Kegiatan',
                  ),
                  controller: waktu,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Waktu tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                Text("Pelaksana"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Pelaksana',
                  ),
                  controller: pelaksana,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Pelaksana tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                FlatButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text('Upload Surat'),
                  onPressed: selectSurat,
                ),
                _pathSurat.isNotEmpty == true ? Text(_pathSurat) : Text('File belum di pilih'),
                SizedBox(height: 20.0),
                FlatButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text('Upload Dokumentasi'),
                  onPressed: selectDokumentasi,
                ),
                _pathDokumentasi.isNotEmpty == true ? Text(_pathDokumentasi) : Text('File belum di pilih'),
                SizedBox(height: 20.0),
                FlatButton(
                  child: Text('TAMBAH KEGIATAN'),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: submitKegiatan,
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}