import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/api.dart' show urlApi;
import './persetujuan-detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersetujuanPrestasi extends StatefulWidget {
  @override
  _PersetujuanPrestasiState createState() => _PersetujuanPrestasiState();
}

class _PersetujuanPrestasiState extends State<PersetujuanPrestasi> {
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
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userIdU = preferences.getString('userid');

    setState(() {
      loading = true;
    });

    http.Response response = await http.get(urlApi + '/api/prestasi-akademik/list.php?role=dosbing&nip=' + userIdU);
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
        title: Text('Nilai Yang Perlu Di Setujui'),
      ),
      body: loading ? Center(
          child: SizedBox(
            width: 100.0,
            height: 100.0,
            child: CircularProgressIndicator(),
          ),
        ) : ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, int index) {
          Map<String, dynamic> persetujuan = data[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text((index + 1).toString()),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => PersetujuanDetail(id: persetujuan['NIM'])
              ));
            },
            title: Text('${persetujuan['nama']}'),
            subtitle: Text('NIM ${persetujuan['NIM']}'),
            trailing: Text('${persetujuan['status']}', style: TextStyle(
              color: Colors.yellow.shade800
            )),
          );
        },
      )
    );
  }
}