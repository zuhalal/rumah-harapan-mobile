import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/prov.dart';

class UCProv extends StatefulWidget {
  const UCProv({Key? key}) : super(key: key);
  static const routeName = '/updateCovid/prov';

  get listProv => null;

  @override
  _UCProvState createState() => _UCProvState();
}

class _UCProvState extends State<UCProv> {
 
  final cardColor = Color.fromRGBO(89, 165, 216, 1);
  List<dynamic> responseJson = [];
  List<Prov> listProv = [];
  
  Future <void> fetchData() async {
    const url = 'http://rumah-harapan.herokuapp.com/updateCovid/jsonProv';
    try {
      final response = await http.get(Uri.parse(url));
      final json = response.body;
      responseJson = jsonDecode(json);
      // print(responseJson);
      int len = responseJson.length;
      for (int i = 0; i < len; i++) {
        Fields fields = Fields(
          kota: responseJson[i]['fields']['kota'],
          positif: responseJson[i]['fields']['positif'], 
          sembuh: responseJson[i]['fields']['sembuh'], 
          kematian: responseJson[i]['fields']['kematian'], 
          urutan: responseJson[i]['fields']['urutan'], 
          );
        
        Prov prov = Prov(
          model: responseJson[i]['model'], 
          pk: responseJson[i]['pk'], 
          fields: fields,
        );

        listProv.add(prov);
      }
      print("Sukses");
      // print(listProv);
      return;
    } catch (error) {
      print(error);
    }
  }

  // void didChangeDependencies() {
  //   fetchData();
  //   super.didChangeDependencies();
  // }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) { // Here you told Flutter to use the word "snapshot".
        if (snapshot.connectionState == ConnectionState.waiting)
          return SizedBox(
            width: double.infinity,
            child: Container(
              color: const Color(0xffade8f4),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          );
        else
          return SizedBox(
            width: double.infinity,
            child: Container(
              color: const Color(0xffade8f4),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Center (
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Data per Provinsi',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color:Color.fromRGBO(89, 165, 216, 1)),
                      ),
                      Text(" ",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color.fromRGBO(89, 165, 216, 1)),
                      ),
                      
                      Table(
                        border: TableBorder.all(),
                        columnWidths: const <int, TableColumnWidth>{
                          0: FlexColumnWidth(),
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                          3: FlexColumnWidth(),
                        },
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: <TableRow>[
                          TableRow(
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(89, 165, 216, 1),
                            ),
                            children: <Widget>[
                              Container(
                                height: 72,
                                child: Center ( 
                                  child:Text(
                                  'Provinsi',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                height: 72,
                                child: Center ( 
                                  child:Text(
                                  'Kasus Positif',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                height: 72,
                                child: Center ( 
                                  child:Text(
                                  'Kasus Sembuh',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                height: 72,
                                child: Center ( 
                                  child:Text(
                                  'Kasus Meninggal',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          for (Prov p in listProv) 
                          TableRow(
                            children: <Widget>[
                              Container(
                                height: 72,
                                child: Center ( 
                                  child:Text(
                                  p.fields.kota,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color.fromRGBO(89, 165, 216, 1)),
                                  ),
                                ),
                              ),
                              Container(
                                height: 72,
                                child: Center ( 
                                  child:Text(
                                  p.fields.positif,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color.fromRGBO(89, 165, 216, 1)),
                                  ),
                                ),
                              ),
                              Container(
                                height: 72,
                                child: Center ( 
                                  child:Text(
                                  p.fields.sembuh,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color.fromRGBO(89, 165, 216, 1)),
                                  ),
                                ),
                              ),
                              Container(
                                height: 72,
                                child: Center ( 
                                  child:Text(
                                  p.fields.kematian,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color.fromRGBO(89, 165, 216, 1)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
              ),
              ),
            ),
          );
      }
    );
  }
}