import 'package:donasi/screens/donasi_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;

import 'package:rumah_harapan/cookies.dart';

class EditDonasiForm extends StatefulWidget {
  static const routeName = '/donasi-edit';
  const EditDonasiForm({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  _EditDonasiFormState createState() => _EditDonasiFormState();
}

class _EditDonasiFormState extends State<EditDonasiForm> {
  TextEditingController dateinput = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String titleFieldsValue = "";
  String deskripsiFieldsValue = "";
  String imageFieldsValue = "";
  String penggalangFieldsValue = "";
  String penerimaFieldsValue = "";
  String targetFieldsValue = "";
  String tenggatFieldsValue = "";
  String linkFieldsValue = "";

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Edit Donasi"),
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
                                Text("Edit Donasi",
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
                                    hintText: "masukan judul donasi",
                                    labelText: "Judul",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        new BorderRadius.circular(5.0)),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Judul tidak boleh kosong';
                                    }
                                    titleFieldsValue = value;
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
                              decoration: new InputDecoration(
                                hintText: "masukan deskripsi donasi",
                                labelText: "Deskripsi",
                                border: OutlineInputBorder(
                                    borderRadius:
                                    new BorderRadius.circular(5.0)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'deskripsi tidak boleh kosong';
                                }
                                deskripsiFieldsValue = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 36,
                            ),
                            TextFormField(
                              autofocus: true,
                              decoration: new InputDecoration(
                                hintText: "masukan link gambar donasi",
                                labelText: "Link Gambar",
                                border: OutlineInputBorder(
                                    borderRadius:
                                    new BorderRadius.circular(5.0)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'link gambar tidak boleh kosong';
                                }
                                imageFieldsValue = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 36,
                            ),
                            TextFormField(
                              autofocus: true,
                              decoration: new InputDecoration(
                                hintText: "masukan nama penggalang donasi",
                                labelText: "Penggalang",
                                border: OutlineInputBorder(
                                    borderRadius:
                                    new BorderRadius.circular(5.0)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'nama penggalang tidak boleh kosong';
                                }
                                penggalangFieldsValue = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 36,
                            ),
                            TextFormField(
                              autofocus: true,
                              decoration: new InputDecoration(
                                hintText: "masukan nama penerima donasi",
                                labelText: "Penerima",
                                border: OutlineInputBorder(
                                    borderRadius:
                                    new BorderRadius.circular(5.0)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'nama penerima tidak boleh kosong';
                                }
                                penerimaFieldsValue = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 36,
                            ),
                            TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                              autofocus: true,
                              decoration: new InputDecoration(
                                hintText: "masukan target donasi",
                                labelText: "Target",
                                border: OutlineInputBorder(
                                    borderRadius:
                                    new BorderRadius.circular(5.0)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'target tidak boleh kosong';
                                }
                                targetFieldsValue = value;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 36,
                            ),
                            TextField(
                              controller: dateinput, //editing controller of this TextField
                              decoration: InputDecoration(
                                  icon: Icon(Icons.calendar_today), //icon of text field
                                  labelText: "Enter Date" //label text of field
                              ), //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context, initialDate: DateTime.now(),
                                    firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101)
                                );

                                if(pickedDate != null ){
                                  //print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                  //you can implement different kind of Date Format here according to your requirement

                                  setState(() {
                                    dateinput.text = formattedDate; //set output date to TextField value.
                                  });
                                }else{
                                  print("Date is not selected");
                                }
                              },
                            ),
                            SizedBox(
                              height: 36,
                            ),
                            TextFormField(
                              autofocus: true,
                              decoration: new InputDecoration(
                                hintText: "masukan link donasi",
                                labelText: "Link Donasi",
                                border: OutlineInputBorder(
                                    borderRadius:
                                    new BorderRadius.circular(5.0)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Link donasi tidak boleh kosong';
                                }
                                linkFieldsValue = value;
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
                                        "http://10.0.2.2:8000/donasi/editAPI/" + widget.id.toString(),
                                        convert.jsonEncode(<String, String>{
                                          'author': request.username,
                                          'title': titleFieldsValue,
                                          'deskripsi': deskripsiFieldsValue,
                                          'link_gambar': imageFieldsValue,
                                          'penggalang': penggalangFieldsValue,
                                          'penerima': penerimaFieldsValue,
                                          'target': targetFieldsValue,
                                          'due_date': dateinput.text,
                                          'link_donasi': linkFieldsValue,
                                        }));
                                    if (response['status'] == 'success') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("Donasi berhasil diedit!"),
                                      ));
                                      Navigator.pushReplacementNamed(
                                          context, DonasiHome.routeName);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content:
                                        Text("An error occured, please try again."),
                                      ));
                                    }}
                              },
                              child: const Text('Donasi Sekarang'),
                            ),
                          ],
                        )
                    )
                  ],
                )
            )
        )
    );
  }
}
