import 'package:flutter/material.dart';

class DashboardMahasiswaApp extends StatefulWidget {
  _DashboardAppState createState() => _DashboardAppState();
}

class _DashboardAppState extends State<DashboardMahasiswaApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bidik Misi'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {

            },
            label: Text('Keluar', style: TextStyle(
              color: Colors.white
            )),
          )
        ],
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
                            Navigator.of(context).pushNamed('/mahasiswa/user');
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
                            Navigator.of(context).pushNamed('/mahasiswa/data');
                          },
                          child: GridTile(
                            child: Icon(Icons.group, size: 40.0, color: Colors.indigo),
                            footer: Text('Data Mahasiswa', textAlign: TextAlign.center, style: TextStyle(
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
                            Navigator.of(context).pushNamed('/mahasiswa/kegiatan');
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
                            Navigator.of(context).pushNamed('/mahasiswa/prestasi-akademik');
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
                            Navigator.of(context).pushNamed('/mahasiswa/organisasi');
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