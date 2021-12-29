import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kritik_saran/models/get_kritik_saran.dart';

class KritikSaranHome extends StatefulWidget {
  @override
  _KritikSaranHomeState createState() => _KritikSaranHomeState();
}

class _KritikSaranHomeState extends State<KritikSaranHome> {
  List<GetKritikSaran> extractedData = [];
  bool isUser = false;

  // Future<List<KritikSaran>> _getKritikSaran() async {
  //   var data = await http
  //       .get(Uri.parse("http://rumah-harapan.herokuapp.com/kritikSaran/json"));

  //   var jsonData = json.decode(data.body);

  //   List<KritikSaran> kritikdansaran = [];

  //   for (var u in jsonData) {
  //     print("U");

  //     KritikSaran kritik =
  //         KritikSaran(u["nama"], u["kritik_saran"], u["waktu_post"]);
  //     print(u);
  //     kritikdansaran.add(kritik);
  //   }
  //   print(kritikdansaran.length);
  //   return kritikdansaran;
  // }

  fetchData() async {
    const url = "http://rumah-harapan.herokuapp.com/kritikSaran/json";

    try {
      extractedData = [];
      final response = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(response.body);

      for (var data in jsonData) {
        Fields fields = Fields(
          nama: data["fields"]["nama"],
          kritikSaran: data["fields"]["kritik_saran"],
          waktuPost: data["fields"]["waktu_post"],
        );

        GetKritikSaran kritiksaran = GetKritikSaran(
            model: data["model"], pk: data["pk"], fields: fields);
        extractedData.add(kritiksaran);
      }
      print(extractedData);
      return extractedData;
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Kritik Saran"),
      ),
      body: Container(
        child: FutureBuilder(
            future: fetchData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              } else {
                print(snapshot.data);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Text(snapshot.data)],
                );
              }
            }),
      ),

      // body: ListView(
      //   children: [
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   // crossAxisAlignment: CrossAxisAlignment.stretch,
      //   children: [
      // Container(
      //   padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      //   decoration: BoxDecoration(
      //     color: const Color(0xffade8f4),
      //   ),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     children: [
      //       Text(
      //         'Kritik dan Saran',
      //         // textAlign: TextAlign.right,
      //         style: TextStyle(
      //             fontSize: 32, color: const Color(0xff59A5D8)),
      //       ),
      //       SizedBox(height: 10),
      //       Text(
      //         'Kami sangat menghargai keinginan Anda untuk membantu kami mengembangkan website yang lebih baik. Anda dapat memberikan kritik dan saran dengan menulis pesan melalui tombol di bawah ini.',
      //         textAlign: TextAlign.justify,
      //       ),
      //     ],
      //   ),
      // ),
      // Container(
      //     decoration: BoxDecoration(
      //       color: const Color(0xffade8f4),
      //     ),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         ElevatedButton(
      //           onPressed: () {},
      //           child: Text('Tambahkan Kritik/Saran'),
      //           style: ElevatedButton.styleFrom(
      //             primary: const Color(0xFF023E8A),
      //             onPrimary: Colors.white,
      //             shadowColor: Colors.transparent,
      //             padding: EdgeInsets.only(
      //                 left: 12, right: 12, top: 8, bottom: 8),
      //             fixedSize: const Size(460, 30),
      //           ),
      //         )
      //       ],
      //     )),
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
      //   children: [
      //     Container(
      //       decoration: BoxDecoration(
      //         color: const Color(0xffade8f4),
      //       ),
      //       child: new Image.asset(
      //           'assets/images/kritik_saran/kritiksaran.png'),
      //       width: 300,
      //       height: 400,
      //     ),
      //   ],
      // )
      //   ],
      // ),
      // SizedBox(height: 20),
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
      //   children: [
      //     Container(
      //       padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      //       child: Text(
      //         'Kritik dan Saran dari Pengguna',
      //         style:
      //             TextStyle(fontSize: 24, color: const Color(0xff59A5D8)),
      //         textAlign: TextAlign.center,
      //       ),
      //     ),
      //   ],
      // ),
      // FutureBuilder(
      //     future: fetchData(),
      //     builder: (BuildContext context, AsyncSnapshot snapshot) {
      //       if (snapshot.data == null) {
      //         return Container(
      //           child: Center(
      //             child: Text("Loading..."),
      //           ),
      //         );
      //       } else {
      //         return ListView.builder(
      //           // itemCount: snapshot.data.
      //           itemBuilder: (BuildContext context, int index) {
      //             return ListTile(
      //                 title: Text(snapshot.data[index].toString()));
      //           },
      //         );
      //       }
      //     }),
      // ],
      // ),
    );
  }
}

// class KritikSaran {
//   final String nama;
//   final String kritikSaran;
//   final String waktuPost;

//   KritikSaran(this.nama, this.kritikSaran, this.waktuPost);
// }
