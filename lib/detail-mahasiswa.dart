import 'dart:convert';

import 'package:flutter/material.dart';
import './config/api.dart' show urlApi;
import 'package:http/http.dart' as http;

class DetailMahasiswa extends StatefulWidget {
  final String nim;
  DetailMahasiswa({
    @required this.nim
  });
  
  _DetailMahasiswaState createState() => _DetailMahasiswaState();
}

class _DetailMahasiswaState extends State<DetailMahasiswa> {
  Map<String, dynamic> data = {};
  bool loading = false;

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
    setState(() {
      loading = true;
    });

    http.Response response = await http.get(urlApi + '/api/mahasiswa/list.php?nim=' + widget.nim);
    var body = jsonDecode(response.body);
    await Future.delayed(Duration(
      seconds: 1
    ));
    setState(() {
      data = body[0];
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Data Mahasiswa'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: loading ? Center(
            child: SizedBox(
              width: 100.0,
              height: 100.0,
              child: CircularProgressIndicator(),
            ),
          ) : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text('${data['nama']}', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Theme.of(context).primaryColor
                )),
              ),
              SizedBox(height: 10.0),
              Center(
                child: Text(data['nim'], style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0
                )),
              ),
              SizedBox(height: 40.0),
              Row(
                children: <Widget>[
                  Text('Tempat, Tanggal Lahir'),
                  SizedBox(width: 20.0),
                  Text('${data['tempat_lahir']}, ${data['tanggal_lahir']}', style: TextStyle(
                    fontWeight: FontWeight.bold
                  ))
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Text('Program Studi'),
                  SizedBox(width: 20.0),
                  Text('${data['program_studi']}', style: TextStyle(
                    fontWeight: FontWeight.bold
                  ))
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Text('Jenjang'),
                  SizedBox(width: 20.0),
                  Text('${data['jenjang']}', style: TextStyle(
                    fontWeight: FontWeight.bold
                  ))
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Text('Fakultas'),
                  SizedBox(width: 20.0),
                  Text('${data['fakultas']}', style: TextStyle(
                    fontWeight: FontWeight.bold
                  ))
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Text('Perguruan Tinggi'),
                  SizedBox(width: 20.0),
                  Text('${data['perguruan_tinggi']}', style: TextStyle(
                    fontWeight: FontWeight.bold
                  ))
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Text('Tahun Masuk - Tahun Keluar'),
                  SizedBox(width: 20.0),
                  Text('${data['tahun_masuk']}-${data['tahun_keluar']}', style: TextStyle(
                    fontWeight: FontWeight.bold
                  ))
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Text('Alamat'),
                  SizedBox(width: 20.0),
                  Text('${data['alamat']}', style: TextStyle(
                    fontWeight: FontWeight.bold
                  ))
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Text('Email'),
                  SizedBox(width: 20.0),
                  Text('${data['email']}', style: TextStyle(
                    fontWeight: FontWeight.bold
                  ))
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Text('Nomor Hp'),
                  SizedBox(width: 20.0),
                  Text('${data['no_hp']}', style: TextStyle(
                    fontWeight: FontWeight.bold
                  ))
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Text('Nama Orang Tua'),
                  SizedBox(width: 20.0),
                  Text('${data['nama_orang_tua']}', style: TextStyle(
                    fontWeight: FontWeight.bold
                  ))
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Text('Nomor Hp Orang Tua'),
                  SizedBox(width: 20.0),
                  Text('${data['no_hp_orang_tua']}', style: TextStyle(
                    fontWeight: FontWeight.bold
                  ))
                ],
              ),
            ],
          ),
        )
      )
    );
  }
}