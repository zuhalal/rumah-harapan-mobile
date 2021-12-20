import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class EditDonasiForm extends StatefulWidget {
  const EditDonasiForm({Key? key}) : super(key: key);

  @override
  _EditDonasiFormState createState() => _EditDonasiFormState();
}

class _EditDonasiFormState extends State<EditDonasiForm> {
  TextEditingController dateinput = TextEditingController();
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
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  Widget build(BuildContext context) {
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
                                    textFieldsValue = value;
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
                                hintText: "masukan gambar donasi",
                                labelText: "Image",
                                border: OutlineInputBorder(
                                    borderRadius:
                                    new BorderRadius.circular(5.0)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'deskripsi tidak boleh kosong';
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
        )
    );
  }
}
