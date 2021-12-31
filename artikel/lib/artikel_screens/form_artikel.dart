import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:artikel/artikel_models/get_artikel.dart';

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

  // String _author = " ";
  // String _title = " ";
  // String _body = " ";

  void kirimData() {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        width: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Penulis: ${controllerAuthor.text}", textAlign: TextAlign.left),
            Text("Judul: ${controllerTitle.text}", textAlign: TextAlign.justify),
            Text("Isi: ${controllerBody.text}", textAlign: TextAlign.justify),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (context) {
        return alert;
      }
    );
  }

  void createArtikel(String author, String title, String body) async {
    final String url = "http://rumah-harapan.herokuapp.com/artikel/json";

    final response = await http.post(Uri.parse(url), body: {
      "author": author,
      "title": title,
      "body": body,
    });

    var data = json.decode(response.body);
    return data;
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
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

              
                  // onChanged: (String str) {
                  //   setState(() {
                  //     _author = str;
                  //   });
                  // },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama penulis tidak boleh kosong';
                    }
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

              
                  // onChanged: (String str) {
                  //   setState(() {
                  //     _title = str;
                  //   });
                  // },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Judul artikel tidak boleh kosong';
                    }
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

              
                  // onChanged: (String str) {
                  //   setState(() {
                  //     _author = str;
                  //   });
                  // },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Isi artikel tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),

              ElevatedButton(
                child: const Text(
                  "Tambahkan",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //kirimData();
                    controllerAuthor.clear();
                    controllerTitle.clear();
                    controllerBody.clear();
                  }
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

