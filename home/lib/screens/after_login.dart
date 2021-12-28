import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:home/widgets/main_drawer_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rumah_harapan/cookies.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../datacovid.dart';


class AfterLogin extends StatefulWidget {
  static const routeName = '/after_login';

  const AfterLogin({Key? key}) : super(key: key);

  @override
  State<AfterLogin> createState() => _AfterLoginState();
}

Future<DataCovid> fetchDataCovid() async {
  final response = await http.get(Uri.parse('https://covid19.mathdro.id/api'));
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

class _AfterLoginState extends State<AfterLogin> {
  final PersistentTabController? _controller =
      PersistentTabController(initialIndex: 0);

  late Future<DataCovid> futureDataCovid;

  List<Widget> _buildScreens() {
    return [];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    String username = request.username;
    final request2 = fetchDataCovid();
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
            padding:
                EdgeInsets.only(top: 160, left: 12, right: 12, bottom: 100),
            child: Column(children: <Widget>[
              Text(
                "Halo,  $username !",
                style: TextStyle(
                  fontSize: 40,
                  color: Color.fromRGBO(89, 165, 216, 1),
                ),
              ),
              const Text(
                'Semoga kamu, keluargamu, dan seluruh #TemanHarapan selalu diberkahi kesehatan dikala pandemi ini.',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(89, 165, 216, 1),
                ),
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
                    Container(
                      child: FutureBuilder<DataCovid>(
                        future: request2,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text("${snapshot.data!.recovered}");
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        },
                      )
                    ),
                    Text(
                      "Jumlah Kematian",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(89, 165, 216, 1),
                      ),
                    ),
                    Container(
                        child: FutureBuilder<DataCovid>(
                          future: request2,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text("${snapshot.data!.deaths}");
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          },
                        )
                    ),
                    Text(
                      "Jumlah COVID",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(89, 165, 216, 1),
                      ),
                    ),
                    Container(
                        child: FutureBuilder<DataCovid>(
                          future: request2,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text("${snapshot.data!.confirmed}");
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          },
                        )
                    ),
                  ],
                ),
              ),
            ]))
      ])),
    );
  }
}
