import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeUC extends StatefulWidget {
  const HomeUC({Key? key}) : super(key: key);

  @override
  _HomeUCState createState() => _HomeUCState();
}

class _HomeUCState extends State<HomeUC> {

  final cardColor = Color.fromRGBO(89, 165, 216, 1);
  int positif = 0;
  int meninggal = 0;
  int sembuh = 0;
  
  Future <void> fetchData() async {
    const url = 'https://covid19.mathdro.id/api/countries/IDN/';
    try {
      final response = await http.get(Uri.parse(url));
      final json = response.body;
      Map<String, dynamic> responseJson = jsonDecode(json);
      // print(responseJson);
      positif = responseJson['confirmed']['value'];
      meninggal = responseJson['deaths']['value'];
      sembuh = responseJson['recovered']['value'];
      return;
    } catch (error) {
      print(error);
    }
  }

  void didChangeDependencies() {
    fetchData();
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        color: const Color(0xffade8f4),
        child: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) { // Here you told Flutter to use the word "snapshot".
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            else
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Update Harian Covid-19 Indonesia',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Color.fromRGBO(89, 165, 216, 1)),
                  ),
                  Text(" ",style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: Color.fromRGBO(89, 165, 216, 1)),),
                  Container(
                    height: 100,
                    child: Card(
                      color: cardColor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const ListTile(
                            title: Text('Kasus Aktif 😷',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
                            ),
                          ),
                          Text(
                            positif.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    child: Card(
                      color: cardColor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const ListTile(
                            title: Text('Sembuh 💉',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white ),
                            ),
                          ),
                          Text(
                            sembuh.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    child: Card(
                      color: cardColor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const ListTile(
                            title: Text('Meninggal ☠️',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
                            ),
                          ),
                          Text(
                            meninggal.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
        ), 
      ),
    );
  }
}