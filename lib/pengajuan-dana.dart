import 'package:flutter/material.dart';

class PengajuanDana extends StatefulWidget {
  @override
  _PengajuanDanaState createState() => _PengajuanDanaState();
}

class _PengajuanDanaState extends State<PengajuanDana> {
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
                  itemCount: 3,
                  itemBuilder: (_, int index) {
                    return ListTile(
                      title: Text('Anggaran Transportasi'),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children : [
                          Text('Pending', style: TextStyle(
                            color: Colors.yellow.shade800
                          )),
                          Text(' - '),
                          Text('Rp 1,000,000')
                        ]
                      ),
                      trailing: FlatButton.icon(
                        color: Theme.of(context).primaryColor,
                        icon: Icon(Icons.view_agenda, size: 16.0),
                        textColor: Colors.white,
                        onPressed: () {

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