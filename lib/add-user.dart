import 'package:flutter/material.dart';
// import 'package:http/http.dart';

class AddUser extends StatefulWidget {
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  String role = 'staff';
  final _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void submit() {
    if (_formKey.currentState.validate()) {
      Map<String, dynamic> dataToSend = {
        'username' : username,
        'password' : password,
        'role' : role
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key:_formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Username"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Username'
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Username tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: username,
                ),
                SizedBox(height: 20.0),
                Text("Password"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Password',
                  ),
                  obscureText: true,
                  controller: password,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                DropdownButton(
                  items: ['staff','pemimpin'].map((v) {
                    return DropdownMenuItem(
                      value: v,
                      child: Text(v)
                    );
                  }).toList(),
                  value: role,
                  onChanged: (String value) {
                    setState(() {
                      role = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                FlatButton(
                  child: Text('TAMBAH USER'),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: submit,
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}