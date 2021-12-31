import 'package:flutter/material.dart';
import 'package:rumah_harapan/widgets/main_drawer_login.dart';
import 'package:rumah_harapan/cookies.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../datacovid.dart';
import 'package:update_covid/models/prov.dart';

class AfterLogin extends StatefulWidget {
  static const routeName = '/after_login';

  const AfterLogin({Key? key}) : super(key: key);

  @override
  State<AfterLogin> createState() => _AfterLoginState();
}

class _AfterLoginState extends State<AfterLogin> {
  late Future<DataCovid> futureDataCovid;
  List<dynamic> responseJson = [];
  List<Prov> listProv = [];

  Future<DataCovid> fetchDataCovid() async {
    await fetchDataTop3();
    final response =
        await http.get(Uri.parse('https://covid19.mathdro.id/api'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return DataCovid.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<void> fetchDataTop3() async {
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
      // print(listProv);
      return;
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    String username = request.username;
    final request3 = fetchDataCovid();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rumah Harapan'),
        backgroundColor: Color.fromRGBO(89, 165, 216, 1),
      ),
      drawer: MainDrawerLogin(),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Container(
            color: Color.fromRGBO(173, 232, 244, 1),
            width: double.infinity,
            padding: EdgeInsets.only(top: 100, left: 12, right: 12, bottom: 50),
            child: Column(children: <Widget>[
              Text(
                "Halo,  $username !",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(89, 165, 216, 1),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              const Text(
                'Semoga kamu, keluargamu, dan seluruh #TemanHarapan selalu diberkahi kesehatan dikala pandemi ini.',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(89, 165, 216, 1),
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: 30),
                padding:
                    EdgeInsets.only(top: 20, left: 12, right: 12, bottom: 20),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Jumlah Sembuh",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(89, 165, 216, 1),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: FutureBuilder<DataCovid>(
                      future: request3,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text("${snapshot.data!.recovered}");
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Jumlah Kematian",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(89, 165, 216, 1),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: FutureBuilder<DataCovid>(
                      future: request3,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text("${snapshot.data!.deaths}");
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Jumlah COVID",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(89, 165, 216, 1),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: FutureBuilder<DataCovid>(
                      future: request3,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text("${snapshot.data!.confirmed}");
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    )),
                  ],
                ),
              ),
            ])),
        FutureBuilder(
          future: fetchDataTop3(),
          builder: (context, snapshot) {
            if (listProv.length != 0) {
              return Container(
                width: double.infinity,
                padding:
                    EdgeInsets.only(top: 100, left: 12, right: 12, bottom: 50),
                child: Column(children: <Widget>[
                  Center(
                    child: Text(
                      "Top 3 Daerah Penyebaran COVID-19",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(89, 165, 216, 1),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Image.asset(
                      'assets/images/home/map.png',
                      height: 300,
                      width: 300,
                    ),
                  ),
                  DataTable(
                    columns: [
                      DataColumn(
                          label: Text('N0',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(89, 165, 216, 1),
                              ))),
                      DataColumn(
                          label: Text('Provinsi',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(89, 165, 216, 1),
                              ))),
                      DataColumn(
                          label: Text('Jumlah Positif',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(89, 165, 216, 1),
                              ))),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('1')),
                        DataCell(
                          Container(
                            height: 72,
                            child: Center(
                              child: Text(
                                listProv[0].fields.kota,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Color.fromRGBO(89, 165, 216, 1)),
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            height: 72,
                            child: Center(
                              child: Text(
                                listProv[0].fields.positif,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Color.fromRGBO(89, 165, 216, 1)),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('2')),
                        DataCell(
                          Container(
                            height: 72,
                            child: Center(
                              child: Text(
                                listProv[1].fields.kota,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Color.fromRGBO(89, 165, 216, 1)),
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            height: 72,
                            child: Center(
                              child: Text(
                                listProv[1].fields.positif,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Color.fromRGBO(89, 165, 216, 1)),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('3')),
                        DataCell(
                          Container(
                            height: 72,
                            child: Center(
                              child: Text(
                                listProv[2].fields.kota,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Color.fromRGBO(89, 165, 216, 1)),
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            height: 72,
                            child: Center(
                              child: Text(
                                listProv[2].fields.positif,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Color.fromRGBO(89, 165, 216, 1)),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]),
              );
            } else {
              return Text("");
            }
          },
        ),
        Container(
          color: Color.fromRGBO(173, 232, 244, 1),
          width: double.infinity,
          padding: EdgeInsets.only(top: 50, left: 12, right: 12, bottom: 50),
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  "Yuk, coba fitur Rumah Harapan",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(89, 165, 216, 1),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/images/home/donate.jpg'),
                    ListTile(
                      title: const Text(
                        'Donasi',
                        style: TextStyle(
                          color: Color.fromRGBO(89, 165, 216, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5, left: 16, right: 16, bottom: 5),
                      child: Text(
                        'Tempat untuk #TemanHarapan saling membantu satu sama lain',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 5, left: 12, right: 16, bottom: 5),
                        child: ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: <Widget>[
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromRGBO(2, 62, 138, 1)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.pressed))
                                      return Color.fromRGBO(2, 62, 138, 1);
                                    return null; // Defer to the widget's default.
                                  }),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/donasi');
                                },
                                child: Text(
                                  "Pelajari lebih lanjut",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ])),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/images/home/new_article.jpg'),
                    ListTile(
                      title: const Text(
                        'Artikel',
                        style: TextStyle(
                          color: Color.fromRGBO(89, 165, 216, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5, left: 16, right: 16, bottom: 5),
                      child: Text(
                        'Tempat untuk menelusuri segala informasi yang berhubungan dengan Pandemi COVID',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 5, left: 12, right: 16, bottom: 5),
                        child: ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: <Widget>[
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromRGBO(2, 62, 138, 1)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.pressed))
                                      return Color.fromRGBO(2, 62, 138, 1);
                                    return null; // Defer to the widget's default.
                                  }),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '');
                                },
                                child: Text(
                                  "Pelajari lebih lanjut",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ])),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/images/home/vaccine.jpg'),
                    ListTile(
                      title: const Text(
                        'Vaksin',
                        style: TextStyle(
                          color: Color.fromRGBO(89, 165, 216, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5, left: 16, right: 16, bottom: 5),
                      child: Text(
                        'Tempat untuk mencari informasi mengenai vaksin di Indonesia',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 5, left: 12, right: 16, bottom: 5),
                        child: ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: <Widget>[
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromRGBO(2, 62, 138, 1)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.pressed))
                                      return Color.fromRGBO(2, 62, 138, 1);
                                    return null; // Defer to the widget's default.
                                  }),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '');
                                },
                                child: Text(
                                  "Pelajari lebih lanjut",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ])),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/images/home/data.jpg'),
                    ListTile(
                      title: const Text(
                        'Data Harian',
                        style: TextStyle(
                          color: Color.fromRGBO(89, 165, 216, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5, left: 16, right: 16, bottom: 5),
                      child: Text(
                        'Tempat mencari penyebaran data covid di setiap daerah di Indonesia',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 5, left: 12, right: 16, bottom: 5),
                        child: ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: <Widget>[
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromRGBO(2, 62, 138, 1)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.pressed))
                                      return Color.fromRGBO(2, 62, 138, 1);
                                    return null; // Defer to the widget's default.
                                  }),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/updateCovid');
                                },
                                child: Text(
                                  "Pelajari lebih lanjut",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ])),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/images/home/ambulance.jpg'),
                    ListTile(
                      title: const Text(
                        'Kontak Penting',
                        style: TextStyle(
                          color: Color.fromRGBO(89, 165, 216, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5, left: 16, right: 16, bottom: 5),
                      child: Text(
                        'Tempat untuk mecari kontak-kontak penting, seperti : rumah sakit dan ambulance',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 5, left: 12, right: 16, bottom: 5),
                        child: ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: <Widget>[
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromRGBO(2, 62, 138, 1)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.pressed))
                                      return Color.fromRGBO(2, 62, 138, 1);
                                    return null; // Defer to the widget's default.
                                  }),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/kontak');
                                },
                                child: Text(
                                  "Pelajari lebih lanjut",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ])),
                  ],
                ),
              ),
            ],
          ),
        ),
      ])),
    );
  }
}
