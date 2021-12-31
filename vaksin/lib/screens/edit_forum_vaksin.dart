import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rumah_harapan/cookies.dart';
import 'package:vaksin/models/konten_vaksin.dart';
import 'package:vaksin/screens/home_vaksin.dart';

class EditForumVaksin extends StatefulWidget {
  static const routeName = '/vaksin-edit';
  const EditForumVaksin({Key? key, required this.id, required this.data})
      : super(key: key);
  final int id;
  final Fields data;
  @override
  _EditForumVaksinState createState() => _EditForumVaksinState();
}

class _EditForumVaksinState extends State<EditForumVaksin> {
  String tanggalPublikasi = DateTime.now().toString();
  final _formKey = GlobalKey<FormState>();
  String judulFieldsValue = '';
  String kontenFieldsValue = '';

  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    judulFieldsValue = widget.data.judul;
    kontenFieldsValue = widget.data.konten;

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Edit Informasi'),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Text('Edit Informasi',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                        color: const Color(0xff59A5D8))),
                                SizedBox(
                                  height: 36,
                                ),
                                TextFormField(
                                  autofocus: true,
                                  decoration: new InputDecoration(
                                    hintText: 'Edit judul informasi',
                                    labelText: 'Judul',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(5.0)),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Judul tidak boleh kosong';
                                    }
                                    judulFieldsValue = value;
                                    return null;
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 36,
                            ),
                            TextFormField(
                              autofocus: true,
                              maxLines: 10,
                              decoration: new InputDecoration(
                                hintText: 'Edit informasi',
                                labelText: 'Informasi',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Informasi tidak boleh kosong';
                                }
                                kontenFieldsValue = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 36,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20),
                                  onPrimary: Colors.white,
                                  primary: const Color(0xff023E8A),
                                  side: BorderSide(
                                      width: 2, color: const Color(0xff023E8A)),
                                  padding: EdgeInsets.only(
                                      left: 12, right: 12, top: 8, bottom: 8),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(8.0))),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final response = await request.postJson(
                                      "http://rumah-harapan.herokuapp.com/vaksin/edit-forum-API" +
                                          widget.id.toString(),
                                      convert.jsonEncode(<String, String>{
                                        'penullis': request.username,
                                        'judul': judulFieldsValue,
                                        'tanggal_publikasi': tanggalPublikasi,
                                        'konten': kontenFieldsValue
                                      }));
                                  if (response['status'] == 'success') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Donasi berhasil diedit!"),
                                    ));
                                    Navigator.pushReplacementNamed(
                                        context, HomeVaksin.routeName);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          "An error occured, please try again."),
                                    ));
                                  }
                                }
                              },
                              child: const Text('Perbarui Informasi'),
                            ),
                          ],
                        ))
                  ],
                ))));
  }
}
