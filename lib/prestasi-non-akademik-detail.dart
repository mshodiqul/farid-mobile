import 'dart:convert';

import './config/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './prestasi-non-akademik-detail-list.dart';

class PrestasiNonAkademikDetail extends StatefulWidget {
  final String nim;
  final String nama;

  PrestasiNonAkademikDetail({
    @required this.nim,
    @required this.nama
  });

  @override
  _PrestasiNonAkademikState createState() => _PrestasiNonAkademikState();
}

class _PrestasiNonAkademikState extends State<PrestasiNonAkademikDetail> {
  bool loading = false;
  List data = [];

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

    http.Response response = await http.get(urlApi + '/api/prestasi-non-akademik/list.php?nim=' + widget.nim);
    
    var body = jsonDecode(response.body);
    print(body);
    setState(() {
      data = body;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Prestasi No Akademik'),
      ),
      body: loading ? Center(
          child: SizedBox(
            width: 100.0,
            height: 100.0,
            child: CircularProgressIndicator(),
          ),
        ) : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: data.length <= 0 ? Center(
            child: Text('Belum Ada Prestasi'),
          ) : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Prestasi Non Akademik Dari Nama Mahasiswa', style: TextStyle(
                fontSize: 25.0,
                color: Theme.of(context).primaryColor
              )),
              SizedBox(height: 10.0),
              Text('Nama Mahasiswa : ${widget.nama}'),
              SizedBox(height: 5.0),
              Text('Nim : ${widget.nim}'),
              SizedBox(height: 30.0),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 250,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (_, int index) {
                    Map<String, dynamic> d = data[index];

                    return ListTile(
                      title: Text(d['Kegiatan']),
                      subtitle: Text(d['Tingkat']),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => PrestasiNonAkademikDetailPage(id: d['id_prestasi_non_akademik'])
                        ));
                      },
                      trailing: Text(d['Hasil'], style: TextStyle(
                        color: Theme.of(context).primaryColor
                      )),
                    );
                  },
                ),
              )
            ]
          )
        )
      )
    );
  }
}