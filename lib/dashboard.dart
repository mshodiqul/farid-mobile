import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './components/drawer-staff.dart';
import 'package:http/http.dart' as http;
import './config/api.dart' show urlApi;

class DashboardApp extends StatefulWidget {
  _DashboardAppState createState() => _DashboardAppState();
}

class _DashboardAppState extends State<DashboardApp> {
  bool loading = false;
  String nama = '';
  String userId = '';
  String role = '';
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetailData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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

    setDeviceToken();
  }

  setDeviceToken() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = preferences.getString('token');
      String userIdU = preferences.getString('userid');
      http.Response response = await http.get(urlApi + '/api/users/register_device.php?token=${token}&user_id=${userIdU}');
      print(response.body);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bidik Misi'),
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
        child: DrawerStaff(nama: nama, userId: userId.toString())
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
                            Navigator.of(context).pushNamed('/user');
                          },
                          child: GridTile(
                            child: Icon(Icons.person, size: 40.0, color: Theme.of(context).primaryColor),
                            footer: Text('User', textAlign: TextAlign.center, style: TextStyle(
                              fontSize: 10.0
                            )),
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(10.0),
                        color: Theme.of(context).secondaryHeaderColor,
                        child: InkWell(
                          splashColor: Colors.green,
                          onTap: () {
                            Navigator.of(context).pushNamed('/mahasiswa');
                          },
                          child: GridTile(
                            child: Icon(Icons.group, size: 40.0, color: Colors.indigo),
                            footer: Text('Mahasiswa', textAlign: TextAlign.center, style: TextStyle(
                              fontSize: 10.0
                            )),
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(10.0),
                        color: Theme.of(context).secondaryHeaderColor,
                        child: InkWell(
                          splashColor: Colors.green,
                          onTap: () {
                            Navigator.of(context).pushNamed('/kegiatan');
                          },
                          child: GridTile(
                            child: Icon(Icons.event, size: 40.0, color: Colors.green),
                            footer: Text('Kegiatan', textAlign: TextAlign.center, style: TextStyle(
                              fontSize: 10.0
                            )),
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(10.0),
                        color: Theme.of(context).secondaryHeaderColor,
                        child: InkWell(
                          splashColor: Colors.green,
                          onTap: () {
                            Navigator.of(context).pushNamed('/prestasi-akademik');
                          },
                          child: GridTile(
                            child: Icon(Icons.grade, size: 40.0, color: Colors.pink),
                            footer: Text('Prestasi Akademik', style: TextStyle(
                              fontSize: 9.0
                            ), textAlign: TextAlign.center),
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(10.0),
                        color: Theme.of(context).secondaryHeaderColor,
                        child: InkWell(
                          splashColor: Colors.green,
                          onTap: () {
                            Navigator.of(context).pushNamed('/prestasi-non-akademik');
                          },
                          child: GridTile(
                            child: Icon(Icons.grade, size: 40.0, color: Colors.purple),
                            footer: Text('Prestasi Non Akademik', style: TextStyle(
                              fontSize: 9.0
                            ), textAlign: TextAlign.center),
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(10.0),
                        color: Theme.of(context).secondaryHeaderColor,
                        child: InkWell(
                          splashColor: Colors.green,
                          onTap: () {
                            Navigator.of(context).pushNamed('/organisasi');
                          },
                          child: GridTile(
                            child: Icon(Icons.group_work, size: 40.0, color: Colors.purple),
                            footer: Text('Organisasi', textAlign: TextAlign.center, style: TextStyle(
                              fontSize: 10.0
                            )),
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(10.0),
                        color: Theme.of(context).secondaryHeaderColor,
                        child: InkWell(
                          splashColor: Colors.green,
                          onTap: () {
                            Navigator.of(context).pushNamed('/karya-tulis');
                          },
                          child: GridTile(
                            child: Icon(Icons.book, size: 40.0, color: Colors.lightBlue),
                            footer: Text('Karya Tulis', style: TextStyle(
                              fontSize: 10.0
                            ), textAlign: TextAlign.center),
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(10.0),
                        color: Theme.of(context).secondaryHeaderColor,
                        child: InkWell(
                          splashColor: Colors.green,
                          onTap: () {
                            Navigator.of(context).pushNamed('/pengajuan-dana');
                          },
                          child: GridTile(
                            child: Icon(Icons.monetization_on, size: 40.0, color: Colors.indigo),
                            footer: Text('Pengajuan Dana', style: TextStyle(
                              fontSize: 10.0
                            ), textAlign: TextAlign.center),
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(10.0),
                        color: Theme.of(context).secondaryHeaderColor,
                        child: InkWell(
                          splashColor: Colors.green,
                          onTap: () {
                            Navigator.of(context).pushNamed('/laporan-semester');
                          },
                          child: GridTile(
                            child: Icon(Icons.collections_bookmark, size: 40.0, color: Colors.green),
                            footer: Text('Laporan Semester', style: TextStyle(
                              fontSize: 9.0
                            ), textAlign: TextAlign.center),
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