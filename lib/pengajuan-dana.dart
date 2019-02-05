import 'dart:convert';
import 'package:flutter/material.dart';
import './config/api.dart';
import 'package:http/http.dart' as http;
import './pengajuan-dana-detail.dart';

class PengajuanDana extends StatefulWidget {
  @override
  _PengajuanDanaState createState() => _PengajuanDanaState();
}

class _PengajuanDanaState extends State<PengajuanDana> {
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

    http.Response response = await http.get(urlApi + '/api/pengajuan-dana/list.php');
    var body = jsonDecode(response.body);
    setState(() {
      data = body;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengajuan Dana'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Pengajuan Dana Yang Di Ajukan Mahasiswa', style: TextStyle(
                fontSize: 25.0,
                color: Theme.of(context).primaryColor
              )),
              SizedBox(height: 40.0),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 250,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (_, int index) {
                    Map<String, dynamic> d = data[index];

                    return ListTile(
                      title: Text(d['Keperluan']),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children : [
                          Text(d['status'].toString().toUpperCase(), style: TextStyle(
                            color: Colors.yellow.shade800
                          )),
                          Text(' - '),
                          Text('Rp ${d['Volume']}')
                        ]
                      ),
                      trailing: FlatButton.icon(
                        color: Theme.of(context).primaryColor,
                        icon: Icon(Icons.view_agenda, size: 16.0),
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => PengajuanDanaDetail(id: d['id_pengajuan'])
                          ));
                        },
                        label: Text('Detail', style: TextStyle(
                          fontSize: 10.0
                        )),
                      ),
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