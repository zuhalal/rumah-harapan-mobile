import 'package:flutter/material.dart';

class AddDonasiForm extends StatefulWidget {
  const AddDonasiForm({Key? key}) : super(key: key);

  @override
  _AddDonasiFormState createState() => _AddDonasiFormState();
}

class _AddDonasiFormState extends State<AddDonasiForm> {
  final _formKey = GlobalKey<FormState>();
  String textFieldsValue = "";
  String deskripsiFieldsValue = "";
  String imageFieldsValue = "";
  String penggalangFieldsValue = "";
  String penerimaFieldsValue = "";
  String targetFieldsValue = "";
  String tenggatFieldsValue = "";
  String linkFieldsValue = "";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Text("Tambahkan Donasi", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: const Color(0xff59A5D8))),
                            SizedBox(height: 36,),
                            TextFormField(
                              autofocus: true,
                              decoration: new InputDecoration(
                                hintText: "masukan judul donasi",
                                labelText: "Judul",
                                border: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(5.0)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Judul tidak boleh kosong';
                                }
                                textFieldsValue = value;
                                return null;
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 36,),
                        TextFormField(
                          autofocus: true,
                          decoration: new InputDecoration(
                            hintText: "masukan deskripsi donasi",
                            labelText: "Deskripsi",
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'deskripsi tidak boleh kosong';
                            }
                            deskripsiFieldsValue = value;
                            return null;
                          },
                        ),
                        SizedBox(height: 36,),
                        TextFormField(
                          autofocus: true,
                          decoration: new InputDecoration(
                            hintText: "masukan gambar donasi",
                            labelText: "Image",
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'deskripsi tidak boleh kosong';
                            }
                            imageFieldsValue = value;
                            return null;
                          },
                        ),
                        SizedBox(height: 36,),
                        TextFormField(
                          autofocus: true,
                          decoration: new InputDecoration(
                            hintText: "masukan nama penggalang donasi",
                            labelText: "Penggalang",
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'nama penggalang tidak boleh kosong';
                            }
                            penggalangFieldsValue = value;
                            return null;
                          },
                        ),
                        SizedBox(height: 36,),
                        TextFormField(
                          autofocus: true,
                          decoration: new InputDecoration(
                            hintText: "masukan nama penerima donasi",
                            labelText: "Penerima",
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'nama penerima tidak boleh kosong';
                            }
                            penerimaFieldsValue = value;
                            return null;
                          },
                        ),
                        SizedBox(height: 36,),
                        TextFormField(
                          autofocus: true,
                          decoration: new InputDecoration(
                            hintText: "masukan target donasi",
                            labelText: "Target",
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'target tidak boleh kosong';
                            }
                            targetFieldsValue = value;
                            return null;
                          },
                        ),
                        SizedBox(height: 36,),
                        TextFormField(
                          autofocus: true,
                          decoration: new InputDecoration(
                            hintText: "masukan tanggal donasi",
                            labelText: "Tenggat waktu",
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Tenggat waktu tidak boleh kosong';
                            }
                            tenggatFieldsValue = value;
                            return null;
                          },
                        ),
                        SizedBox(height: 36,),
                        TextFormField(
                          autofocus: true,
                          decoration: new InputDecoration(
                            hintText: "masukan link donasi",
                            labelText: "Link Donasi",
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Link donasi tidak boleh kosong';
                            }
                            linkFieldsValue = value;
                            return null;
                          },
                        ),
                        SizedBox(height: 36,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),
                              onPrimary: Colors.white,
                              primary: const Color(0xff023E8A),
                              side: BorderSide(width: 2,color: const Color(0xff023E8A)),
                              padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print(textFieldsValue);
                              print(deskripsiFieldsValue);
                              print(imageFieldsValue);
                              print(penggalangFieldsValue);
                              print(penerimaFieldsValue);
                              print(targetFieldsValue);
                              print(tenggatFieldsValue);
                              print(linkFieldsValue);
                            }
                          },
                          child: const Text('Donasi Sekarang'),
                        ),
                      ],
                    )
                )
              ],
            )
        )
    );
  }
}
