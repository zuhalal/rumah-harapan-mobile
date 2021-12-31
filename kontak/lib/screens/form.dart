import '../screens/home_kontak.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import 'package:rumah_harapan/cookies.dart';

class AddKontakForm extends StatefulWidget {
  static const routeName = '/kontak-add';
  const AddKontakForm({Key? key}) : super(key: key);

  @override
  _AddKontakFormState createState() => _AddKontakFormState();
}

class _AddKontakFormState extends State<AddKontakForm> {
  //TextEditingController dateinput = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String regionFieldsValue = "";
  String provinsiFieldsValue = "";
  String kategoriFieldsValue = "";
  String kotaFieldsValue = "";
  String namakontakFieldsValue = "";
  String nomorkontakFieldsValue = "";
  String alamatkontakFieldsValue = "";
  String keteranganFieldsValue = "";

  List listRegion = [
    "Nasional",
    "Jawa",
    "Sumatra",
    "Kalimantan",
    "Sulawesi",
    "Bali",
    "Papua"
  ];
  List listKategori = [
    "Hotline COVID-19",
    "Rumah Sakit",
    "Ambulans",
    "Bank Darah",
    "Suplier Alkes",
    "Lainnya"
  ];
  List listProvinsi = [
    "Aceh",
    "Sumatera Utara",
    "Sumatera Barat",
    "Riau",
    "Jambi",
    "Sumatera Selatan",
    "Bengkulu",
    "Lampung",
    "Kep. Bangka Belitung",
    "Kep. Riau",
    "DKI Jakarta",
    "Jawa Barat",
    "Jawa Tengah",
    "DI. Yogyakarta",
    "Jawa Timur",
    "Banten",
    "Bali",
    "NTB",
    "NTT",
    "Kalimantan Barat",
    "Kalimantan Selatan",
    "Kalimantan Tengah",
    "Kalimantan Timur",
    "Kalimantan Utara",
    "Sulawesi Barat",
    "Sulawesi Selatan",
    "Sulawesi Tengah",
    "Sulawesi Tenggara",
    "Sulawesi Utara",
    "Gorontalo",
    "Maluku",
    "Mauluku Utara",
    "Papua",
    "Papua Barat"
  ];

  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Tambahkan Kontak"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
                                const Text("Tambahkan Kontak",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                        color: Color(0xff59A5D8))),
                                const SizedBox(
                                  height: 36,
                                ),
                                DropdownButtonFormField(
                                  autofocus: true,
                                  decoration: new InputDecoration(
                                    hintText: "masukan region",
                                    labelText: "Region",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(5.0)),
                                  ),
                                  items: listRegion.map((value) {
                                    return DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      regionFieldsValue = value.toString();
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 36,
                            ),
                            DropdownButtonFormField(
                              autofocus: true,
                              decoration: new InputDecoration(
                                hintText: "masukan provinsi",
                                labelText: "Provinsi",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0)),
                              ),
                              items: listProvinsi.map((value) {
                                return DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  provinsiFieldsValue = value.toString();
                                });
                              },
                            ),
                            const SizedBox(
                              height: 36,
                            ),
                            DropdownButtonFormField(
                                autofocus: true,
                                decoration: new InputDecoration(
                                  hintText: "masukan kategori",
                                  labelText: "Kategori",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0)),
                                ),
                                items: listKategori.map((value) {
                                  return DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    kategoriFieldsValue = value.toString();
                                  });
                                }
                                // validator: (value) {
                                //   //var isEmpty;
                                //   if (value == null) {
                                //     return 'Kategori tidak boleh kosong';
                                //   }
                                //   kategoriFieldsValue = value.toString();
                                //   return null;
                                // },
                                ),
                            const SizedBox(
                              height: 36,
                            ),
                            TextFormField(
                              autofocus: true,
                              decoration: new InputDecoration(
                                hintText: "masukan nama kota",
                                labelText: "Kota",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'nama kota tidak boleh kosong';
                                }
                                kotaFieldsValue = value;
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 36,
                            ),
                            TextFormField(
                              autofocus: true,
                              decoration: new InputDecoration(
                                hintText: "masukan nama kontak",
                                labelText: "Nama Kontak",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'nama kontak tidak boleh kosong';
                                }
                                namakontakFieldsValue = value;
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 36,
                            ),
                            TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                              autofocus: true,
                              decoration: new InputDecoration(
                                hintText: "masukan nomor kontak",
                                labelText: "Nomor Kontak",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'nomor kontak tidak boleh kosong';
                                }
                                nomorkontakFieldsValue = value;
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 36,
                            ),
                            TextFormField(
                              autofocus: true,
                              decoration: new InputDecoration(
                                hintText: "masukan alamat kontak",
                                labelText: "Alamat Kontak",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'alamat kontak tidak boleh kosong';
                                }
                                alamatkontakFieldsValue = value;
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 36,
                            ),
                            TextFormField(
                              autofocus: true,
                              decoration: new InputDecoration(
                                hintText: "masukan keterangan",
                                labelText: "Keterangan",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'keterangan tidak boleh kosong';
                                }
                                keteranganFieldsValue = value;
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 36,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20),
                                  onPrimary: Colors.white,
                                  primary: const Color(0xff023E8A),
                                  side: const BorderSide(
                                      width: 2, color: Color(0xff023E8A)),
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, top: 8, bottom: 8),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(8.0))),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final response = await request.postJson(
                                      "http://rumah-harapan.herokuapp.com/kontak/addAPI",
                                      convert.jsonEncode(<String, String>{
                                        'region': regionFieldsValue,
                                        'provinsi': provinsiFieldsValue,
                                        'kategori': kategoriFieldsValue,
                                        'kota': kotaFieldsValue,
                                        'namakontak': namakontakFieldsValue,
                                        'nomorkontak': nomorkontakFieldsValue,
                                        'alamatkontak': alamatkontakFieldsValue,
                                        'keterangan': keteranganFieldsValue,
                                      }));
                                  if (response['status'] == 'success') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          "Kontak baru telah berhasil disimpan!"),
                                    ));
                                    Navigator.pushReplacementNamed(
                                        context, ContactHome.routeName);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          "An error occured, please try again."),
                                    ));
                                  }
                                }
                              },
                              child: const Text('Tambahkan'),
                            ),
                          ],
                        ))
                  ],
                ))));
  }
}
