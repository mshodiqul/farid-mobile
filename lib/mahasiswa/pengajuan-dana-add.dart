import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/api.dart' show urlApi;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

class MahasiswaPengajuanDanaTambah extends StatefulWidget {
  @override
  _MahasiswaPengajuanDanaTambahState createState() => _MahasiswaPengajuanDanaTambahState();
}

class _MahasiswaPengajuanDanaTambahState extends State<MahasiswaPengajuanDanaTambah> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController keperluan = new TextEditingController();
  TextEditingController volume = new TextEditingController();
  bool loading = false;
  String userId = '';

  File _fileSK;
  String _pathSK = '';

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

    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('userid');
    setState(() {
      loading = false;
    });
  }

  selectNota() async {
    try {
      _pathSK = await FilePicker.getFilePath(type: FileType.ANY);
      setState(() {
        _fileSK = new File(_pathSK);
      });
    } catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  simpanPrestasi() async {
    setState(() {
      loading = true;
    });

    Map<String, dynamic> dataToSend = {
      'nim' : userId,
      'keperluan' : keperluan.text,
      'volume' : volume.text,
      'nota_base64' : base64Encode(_fileSK.readAsBytesSync()),
      'nota_ext' : _pathSK.split('/').last
    };
    http.Response response = await http.post(urlApi + '/api/pengajuan-dana/tambah.php', body: dataToSend);

    setState(() {
      loading = false;
    });

    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Berhasil'),
        content: Text('Pengajuan Dana Berhasil Kirim'),
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
        title: Text('Ajukan Dana Baru'),
      ),
      body: loading ? Center(
          child: SizedBox(
            width: 100.0,
            height: 100.0,
            child: CircularProgressIndicator(),
          ),
        ) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key:_formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Keperluan"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Keperluan Pengajuan Dana'
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Keperluan tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: keperluan,
                ),
                SizedBox(height: 20.0),
                Text("Nominal Dana"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Nominal Yang Ingin Di Ajukan'
                  ),
                  keyboardType: TextInputType.number,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Nominal tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: volume,
                ),
                SizedBox(height: 20.0),
                FlatButton.icon(
                  icon: Icon(Icons.cloud_upload),
                  textColor: Theme.of(context).primaryColor,
                  label: Text('Upload Nota', style: TextStyle(
                    fontWeight: FontWeight.bold
                  )),
                  onPressed: selectNota,
                ),
                _pathSK.isNotEmpty ? Text(_pathSK) : Text('Sertifikat Belum Di Pilih'),
                SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: FlatButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: simpanPrestasi,
                    child: Text('KIRIM', style: TextStyle(
                      color: Colors.white
                    )),
                  ),
                )
              ]
            )
          )
        )
      )
    );
  }
}