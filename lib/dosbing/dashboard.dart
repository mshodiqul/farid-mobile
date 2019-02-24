import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/drawer-dosbing.dart';
import 'package:http/http.dart' as http;
import '../config/api.dart' show urlApi;
import 'package:badges/badges.dart';

class DashboardDosbing extends StatefulWidget {
  _DashboardDosbingState createState() => _DashboardDosbingState();
}

class _DashboardDosbingState extends State<DashboardDosbing> {
  bool loading = false;
  String nama = '';
  String userId = '';
  String role = '';
  int totalPending = 0;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetailData();
    setDeviceToken();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  setDeviceToken() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = preferences.getString('token');
      String userIdU = preferences.getString('userid');
      http.Response response = await http.get(urlApi + '/api/users/register_device.php?token=${token}&user_id=${userIdU}');
      print(response.body);
  }

  getDetailData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userIdU = preferences.getString('userid');
    String namaU = preferences.getString('nama');
    String roleU = preferences.getString('role');

    setState(() {
      loading = false;
      nama = namaU;
      role = roleU;
      userId = userIdU;
    });

    getTotalPersetujuanPending();
  }

  getTotalPersetujuanPending() async {
    http.Response response = await http.get(urlApi + '/api/prestasi-akademik/pending-total.php');
    var body = jsonDecode(response.body);

    setState(() {
      totalPending = int.parse(body[0]['total']);
      loading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bidik Misi - Dosbing'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () async {
              SharedPreferences preferences = await SharedPreferences.getInstance();
              preferences.clear();
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
            },
            label: Text('Keluar', style: TextStyle(
              color: Colors.white
            )),
          )
        ],
      ),
      drawer: Drawer(
        child: DrawerDosbing(nama: nama, userId: userId.toString())
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            SizedBox(width: double.infinity, height: 300.0, child: Container(
              color: Theme.of(context).primaryColor
            )),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Container(
                  margin: EdgeInsets.only(top: 50.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(
                      blurRadius: 5.0,
                      color: Colors.grey
                    )]
                  ),
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        color: Theme.of(context).secondaryHeaderColor,
                        child: InkWell(
                          splashColor: Colors.green,
                          onTap: () {
                            Navigator.of(context).pushNamed('/dosbing/persetujuan');
                          },
                          child: GridTile(
                            child: BadgeIconButton(
                              icon: Icon(Icons.person, size: 40.0, color: Theme.of(context).primaryColor),
                              itemCount: totalPending,
                            ),
                            footer: Text('Persetujuan Prestasi', textAlign: TextAlign.center, style: TextStyle(
                              fontSize: 10.0
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}