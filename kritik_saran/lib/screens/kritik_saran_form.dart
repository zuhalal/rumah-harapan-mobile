import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:kritik_saran/screens/kritik_saran_home.dart';
import 'package:provider/provider.dart';
import 'package:rumah_harapan/cookies.dart';

class KritikSaranForm extends StatefulWidget {
  const KritikSaranForm({Key? key}) : super(key: key);

  @override
  _KritikSaranFormState createState() => _KritikSaranFormState();
}

class _KritikSaranFormState extends State<KritikSaranForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerKritikSaran = TextEditingController();
  String namaValue = "";
  String kritikValue = "";
  DateTime tanggal = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: Text("Form Kritik Saran"),
        ),
        body: ListView(
          children: [
            Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Kritik dan Saran',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Masukan Anda sangat bermanfaat bagi kami.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controllerNama,
                        decoration: InputDecoration(
                          hintText: "Masukkan nama Anda (boleh nama samaran)",
                          labelText: "Nama",
                          icon: const Icon(Icons.people),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          namaValue = value;
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controllerKritikSaran,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Masukkan kritik dan saran",
                          labelText: "Kritik dan Saran",
                          icon: const Icon(Icons.message),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Kritik dan saran tidak boleh kosong';
                          }
                          kritikValue = value;
                          return null;
                        },
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        onPrimary: Colors.white,
                        primary: const Color(0xff023E8A),
                        side: BorderSide(
                            width: 2, color: const Color(0xff023E8A)),
                        padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0)),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final response = await request.postJson(
                              "http://rumah-harapan.herokuapp.com/kritikSaran/addKritik",
                              convert.jsonEncode(<String, String>{
                                'nama': namaValue,
                                'kritik_saran': kritikValue,
                                'waktu_post': tanggal.toString(),
                              }));

                          if (response['status'] == 'success') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  "Kritik dan Saran telah berhasil ditambahkan"),
                            ));
                            Navigator.pushReplacementNamed(
                                context, KritikSaranHome.routeName);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Coba lagi"),
                            ));
                          }
                        }
                      },
                      child: const Text("Submit"),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                          onPrimary: Colors.white,
                          primary: const Color(0xff023E8A),
                          side: BorderSide(
                              width: 2, color: const Color(0xff023E8A)),
                          padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0)),
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: const Text("Kembali")),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
