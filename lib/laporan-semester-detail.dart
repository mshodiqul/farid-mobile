import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './config/api.dart' show urlApi;
import 'package:charts_flutter/flutter.dart';

class LaporanSemesterDetail extends StatefulWidget {
  final String nama;
  final String nim;
  LaporanSemesterDetail({
    @required this.nim,
    @required this.nama
  });

  @override
  _LaporanSemesterDetailState createState() => _LaporanSemesterDetailState();
}

class _LaporanSemesterDetailState extends State<LaporanSemesterDetail> {
  bool loading = false;
  Map<String, dynamic> data = {};
  List<Series<dynamic, String>> series = [];

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

    http.Response response = await http.get(urlApi + '/api/prestasi-akademik/list.php?nim=' + widget.nim);
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

    setChart();
  }

  setChart() async {
    setState(() {
      loading = true;
    });

    var chartData = [
      DataSemesterChart('S.1', int.parse(data['Nilai_Semester1'])),
      DataSemesterChart('S.2', int.parse(data['Nilai_Semester2'])),
      DataSemesterChart('S.3', int.parse(data['Nilai_Semester3'])),
      DataSemesterChart('S.4', int.parse(data['Nilai_Semester4'])),
      DataSemesterChart('S.5', int.parse(data['Nilai_Semester5'])),
      DataSemesterChart('S.6', int.parse(data['Nilai_Semester6'])),
      DataSemesterChart('S.7', int.parse(data['Nilai_Semester7'])),
      DataSemesterChart('S.8', int.parse(data['Nilai_Semester8'])),
    ];

    List<Series<dynamic, String>> seriess = [
      Series(
        id: 'semester',
        domainFn: (dsc, _) => dsc.title,
        measureFn: (dsc, _) {
          return dsc.nilai;
        },
        data: chartData
      )
    ];

    setState(() {
      series = seriess;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Prestasi Akademik'),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Prestasi Akademik Dari Mahasiswa', style: TextStyle(
                fontSize: 25.0,
                color: Theme.of(context).primaryColor
              )),
              SizedBox(height: 40.0),
              SizedBox(
                width: double.infinity,
                height: 400.0,
                child: loading ? Container() : BarChart(
                  series,
                  animate: true,
                )
              )
            ],
          ),
        ),
      )
    );
  }
}

class DataSemesterChart {
  final String title;
  final int nilai;

  DataSemesterChart(this.title, this.nilai);
}