import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:artikel/artikel_screens/artikel_home.dart';
import 'package:provider/provider.dart';
import 'package:rumah_harapan/cookies.dart';

class ArtikelForm extends StatefulWidget {
  const ArtikelForm({Key? key}) : super(key: key);

  @override
  _ArtikelFormState createState() => _ArtikelFormState();
}

class _ArtikelFormState extends State<ArtikelForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController controllerAuthor = TextEditingController();
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerBody = TextEditingController();

  String authorValue = " ";
  String titleValue = " ";
  String bodyValue = " ";
  DateTime date = DateTime.now();

  // void kirimData() {
  //   AlertDialog alert = AlertDialog(
  //     content: SizedBox(
  //       width: 250,
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           Text("Penulis: ${controllerAuthor.text}", textAlign: TextAlign.left),
  //           Text("Judul: ${controllerTitle.text}", textAlign: TextAlign.justify),
  //           Text("Isi: ${controllerBody.text}", textAlign: TextAlign.justify),
  //           const SizedBox(height: 10),
  //           ElevatedButton(
  //             child: const Text("OK"),
  //             onPressed: () => Navigator.pop(context),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return alert;
  //     }
  //   );
  // }

  // void createArtikel(String author, String title, String body) async {
  //   final String url = "http://rumah-harapan.herokuapp.com/artikel/json";

  //   final response = await http.post(Uri.parse(url), body: {
  //     "author": author,
  //     "title": title,
  //     "body": body,
  //   });

  //   var data = json.decode(response.body);
  //   return data;
  // }

  @override 
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
          title: Text("Form Artikel"),
        ),
      body: ListView(
        children: [
          Form(
            key: _formKey,
        
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    'Artikel',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controllerAuthor,
                      decoration: InputDecoration(
                        hintText: "Nama penulis",
                        labelText: 'Author',
                        icon: const Icon(Icons.people),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nama penulis tidak boleh kosong';
                        }
                        authorValue = value;
                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controllerTitle,
                      decoration: InputDecoration(
                        hintText: "Judul Artikel",
                        labelText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Judul artikel tidak boleh kosong';
                        }
                        titleValue = value;
                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controllerBody,
                      decoration: InputDecoration(
                        hintText: "Isi Artikel",
                        labelText: 'Body',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Isi artikel tidak boleh kosong';
                        }
                        bodyValue = value;
                        return null;
                      },
                    ),
                  ),

                  ElevatedButton(
                    child: const Text(
                      "Tambahkan",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async{
                      if (_formKey.currentState!.validate()) {
                        final response = await request.postJson(
                              "http://rumah-harapan.herokuapp.com/artikel/addArtikel",
                              convert.jsonEncode(<String, String>{
                                'author': authorValue,
                                'title': titleValue,
                                'body': bodyValue,
                                'date': date.toString(),
                              }));

                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                "Artikel telah berhasil dipublikasikan"),
                          ));
                          Navigator.pushReplacementNamed(
                              context, ArtikelHome.routeName);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Coba lagi"),
                          ));
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                        child: const Text(
                          "Kembali",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        }),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}

