import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/api.dart' show urlApi;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

class ProfileMahasiswa extends StatefulWidget {
  @override
  _ProfileMahasiswaState createState() => _ProfileMahasiswaState();
}

class _ProfileMahasiswaState extends State<ProfileMahasiswa> {
  TextEditingController namaController = TextEditingController();
  TextEditingController tempatLahirController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  TextEditingController prodiController = TextEditingController();
  TextEditingController jenjangController = TextEditingController();
  TextEditingController fakultasController = TextEditingController();
  TextEditingController perguruanController = TextEditingController();
  TextEditingController tahunMasukController = TextEditingController();
  TextEditingController tahunKeluarController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nohpController = TextEditingController();
  TextEditingController noRekeningController = TextEditingController();
  TextEditingController namaOrangTuaController = TextEditingController();
  TextEditingController noHpOrangTuaController = TextEditingController();
  String namaBank = 'BRI';
  String status = 'belum lulus';

  bool editable = false;
  bool loading = false;
  Map<String, dynamic> data = {};
  File _fileProfile;
  String _pathProfile = '';

  File _fileRekening;
  String _pathRekening = '';

  String urlFoto = '';
  
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
    String userId = preferences.getString('userid');
    setState(() {
      loading = true;
    });

    http.Response response = await http.get(urlApi + '/api/mahasiswa/list.php?nim=' + userId);
    var body = jsonDecode(response.body);
    await Future.delayed(Duration(
      seconds: 1
    ));
    setState(() {
      data = body.length > 0 ? body[0] : {};
      loading = false;
    });
    parsingData();
  }

  parsingData() async {
    if (data['nim'].toString().isNotEmpty) {
      namaController.text = data['nama'];
      tempatLahirController.text = data['tempat_lahir'];
      tanggalLahirController.text = data['tanggal_lahir'];
      prodiController.text = data['program_studi'];
      jenjangController.text = data['jenjang'];
      fakultasController.text = data['fakultas'];
      perguruanController.text = data['perguruan_tinggi'];
      tahunMasukController.text = data['tahun_masuk'];
      tahunKeluarController.text = data['tahun_keluar'];
      alamatController.text = data['alamat'];
      emailController.text = data['email'];
      nohpController.text = data['no_hp'];
      noRekeningController.text = data['no_rekening'];
      namaOrangTuaController.text = data['nama_orang_tua'];
      noHpOrangTuaController.text = data['no_hp_orang_tua'];
      namaBank = data['nama_bank'];
      status = data['status'];

      if (data['foto'] != null && data['foto'].toString().isNotEmpty) {
        urlFoto = data['foto'];
      }
    }
  }

  saveData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userId = preferences.getString('userid');

    Map<String, dynamic> dataToSend = {
      'nim' : userId,
      'nama' : namaController.text,
      'tempat_lahir' : tempatLahirController.text,
      'tanggal_lahir' : tanggalLahirController.text,
      'program_studi' : prodiController.text,
      'jenjang' : jenjangController.text,
      'fakultas' : fakultasController.text,
      'perguruan_tinggi' : perguruanController.text,
      'tahun_masuk' : tahunMasukController.text,
      'tahun_keluar' : tahunKeluarController.text,
      'alamat' : alamatController.text,
      'email' : emailController.text,
      'no_hp' : nohpController.text,
      'no_rekening' : noRekeningController.text,
      'nama_bank' : namaBank,
      'status' : status,
      'nama_orang_tua' : namaOrangTuaController.text,
      'no_hp_orang_tua' : noHpOrangTuaController.text
    };

    if (_pathProfile.isNotEmpty) {
      dataToSend['profile_base64'] = base64Encode(_fileProfile.readAsBytesSync());
      dataToSend['profile_ext'] = _pathProfile.split('/').last;
    }

    if (_pathRekening.isNotEmpty) {
      dataToSend['rekening_base64'] = base64Encode(_fileRekening.readAsBytesSync());
      dataToSend['rekening_ext'] = _pathRekening.split('/').last;
    }

    
    http.Response response = await http.post(urlApi + '/api/mahasiswa/edit-mahasiswa.php?nim=' + userId, body: dataToSend);
    print(response.body);
    var body = jsonDecode(response.body);

    this.setState(() {
      loading = true;
    });

    await Future.delayed(Duration(seconds: 1));
    this.setState(() {
      loading = false;
      editable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Anda')
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: editable ? Colors.green : Theme.of(context).primaryColor,
        child : !editable ? Icon(Icons.edit) : Icon(Icons.save),
        onPressed: () {
          if (editable) {
            saveData();
          } else {
            this.setState(() {
              editable = true;
            });
          }
        }
      ),
      body: loading ? Center(
          child: SizedBox(
            width: 100.0,
            height: 100.0,
            child: CircularProgressIndicator(),
          ),
        ) :  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    child: InkWell(
                      onTap: () async {
                        try {
                          _pathProfile = await FilePicker.getFilePath(type: FileType.IMAGE);
                          setState(() {
                            _fileProfile = new File(_pathProfile);
                          });
                        } catch (e) {
                          print("Unsupported operation" + e.toString());
                        }
                      },
                      child: urlFoto.isNotEmpty ? CircleAvatar(
                        child: _fileProfile != null ? Image.file(_fileProfile,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity) : Image.network(urlApi + '/files/' + urlFoto,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,),
                          radius: 80.0
                        ) : CircleAvatar(
                          child: _fileProfile != null ? Image.file(_fileProfile,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity) : Icon(Icons.person, color: Colors.white, size: 100.0),
                            radius: 80.0
                        ),
                    ),
                  ),
                ),
                Center(
                  child: FlatButton(
                    child: Text('Ganti Password'),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/ganti-password');
                    },
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 40.0),
                Text('Nama Lengkap'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  controller: namaController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Nama Tidak Boleh Kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),

                Text('Tempat Lahir'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Tempat Lahir Tidak Boleh Kosong';
                    }
                    return null;
                  },
                  controller: tempatLahirController,
                ),
                SizedBox(height: 20.0),

                Text('Tanggal Lahir'),
                SizedBox(height: 10.0),
                InkWell(
                  onTap: editable ? () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime(1999, 2, 11),
                      firstDate: DateTime(1970, 1, 1),
                      lastDate: DateTime(1999, 12, 12)
                    ).then((value) {
                      tanggalLahirController.text = value.year.toString() + '-' + value.month.toString() + '-' + value.day.toString();
                    });
                  } : () {},
                  child: TextFormField(
                    enabled: false,
                    controller: tanggalLahirController,
                    keyboardType: TextInputType.datetime,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Tanggal Lahir Tidak Boleh Kosong';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20.0),

                Text('PRODI'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  controller: prodiController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Produ Tidak Boleh Kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),

                Text('JENJANG'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  controller: jenjangController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Jenjang Tidak Boleh Kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),

                Text('Fakultas'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  controller: fakultasController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Fakultas Tidak Boleh Kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),

                Text('Perguruan Tinggi'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  controller: perguruanController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Perguruan Tinggi Tidak Boleh Kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),

                Text('Tahun Masuk'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  controller: tahunMasukController,
                  keyboardType: TextInputType.number,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Tahun Masuk Tidak Boleh Kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),

                Text('TAHUN KELUAR'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  controller: tahunKeluarController
                ),
                SizedBox(height: 20.0),

                Text('ALAMAT'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  controller: alamatController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Alamat Tidak Boleh Kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),

                Text('EMAIL'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  controller: emailController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Email Tidak Boleh Kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),

                Text('NO HP'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  controller: nohpController,
                  keyboardType: TextInputType.phone,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Nomor Hp Tidak Boleh Kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),

                Text('NOMOR REKENING'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  controller: noRekeningController,
                  keyboardType: TextInputType.number,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Nomor Rekening Tidak Boleh Kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      items: ['BRI','BCA','MANDIRI','BNI','DANAMON','BTPN'].map((v) {
                        return DropdownMenuItem(
                          child: Text(v),
                          value: v,
                        );
                      }).toList(),
                      onChanged: (v) {
                        setState(() {
                          namaBank = v;
                        });
                      },
                      value: namaBank,
                    )
                  ),
                ),
                FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () async {
                    try {
                      _pathRekening = await FilePicker.getFilePath(type: FileType.IMAGE);
                      setState(() {
                        _fileRekening = new File(_pathRekening);
                      });
                    } catch (e) {
                      print("Unsupported operation" + e.toString());
                    }
                  },
                  child: Text('Upload Buku Tabungan'),
                ),
                SizedBox(height: 20.0),

                Text('NAMA ORANG TUA'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  controller: namaOrangTuaController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Nama Orang Tua Tidak Boleh Kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),


                Text('NO HP ORANG TUA'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  controller: noHpOrangTuaController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Nomor Hp Orang Tua Tidak Boleh Kosong';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20.0),
                Text('Apakah Status Anda Sudah Lulus ?'),
                SizedBox(height: 10.0),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      items: ['lulus','belum lulus'].map((v) {
                        return DropdownMenuItem(
                          child: Text(v),
                          value: v,
                        );
                      }).toList(),
                      onChanged: (v) {
                        setState(() {
                          status = v;
                        });
                      },
                      value: status,
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );    
  }
}