import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/api.dart' show urlApi;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

class KaryaTulisTambah extends StatefulWidget {
  @override
  _KaryaTulisState createState() => _KaryaTulisState();
}

class _KaryaTulisState extends State<KaryaTulisTambah> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController judul = TextEditingController();
  TextEditingController bidang = TextEditingController();
  
  File _fileSK;
  String _pathSK = '';
  String userId = '';

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

  selectSK() async {
    try {
      _pathSK = await FilePicker.getFilePath(type: FileType.ANY);
      setState(() {
        _fileSK = new File(_pathSK);
      });
    } catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  submit() async {
    Map<String, dynamic> dataToSend = {
      'nim' : userId,
      'judul' : judul.text,
      'bidang' : bidang.text,
      'sk_base64' : base64Encode(_fileSK.readAsBytesSync()),
      'sk_ext' : _pathSK.split('/').last
    };
    http.Response response = await http.post(urlApi + '/api/karya-tulis/tambah.php', body: dataToSend);
    print(response.body);

    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Berhasil'),
        content: Text('KaryaTulis Berhasil Tambahkan'),
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
        title: Text('Tambah Riwayat KaryaTulis Baru'),
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
                Text("Judul Karya Tulis"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Judul Karya Tulis'
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Judul Karya Tulis tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: judul,
                ),
                SizedBox(height: 20.0),
                Text("Bidang"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan bidang di KaryaTulis'
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Bidang tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: bidang,
                ),
                SizedBox(height: 20.0),
                FlatButton.icon(
                  icon: Icon(Icons.cloud_upload),
                  textColor: Theme.of(context).primaryColor,
                  label: Text('Upload Berkas', style: TextStyle(
                    fontWeight: FontWeight.bold
                  )),
                  onPressed: selectSK,
                ),
                _pathSK.isNotEmpty ? Text(_pathSK) : Text('Berkas Belum Di Pilih'),
                SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: FlatButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: submit,
                    child: Text('SIMPAN', style: TextStyle(
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