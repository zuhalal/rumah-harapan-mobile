import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:donasi/models/all_donasi.dart';
import 'package:donasi/screens/donasi_add_form.dart';
import 'package:donasi/widgets/container_donasi.dart';
import 'package:flutter/material.dart';
import 'package:donasi/widgets/card_carousel.dart';
import 'package:http/http.dart' as http;
import 'package:rumah_harapan/widgets/drawer.dart';

class DonasiHome extends StatefulWidget {
  const DonasiHome({Key? key}) : super(key: key);

  @override
  _DonasiHomeState createState() => _DonasiHomeState();
}

class _DonasiHomeState extends State<DonasiHome> {
  List<AllDonasi> extractedData = [];
  bool isUser = false;

  fetchData() async {
    // const url = 'http://10.0.2.2:8000/donasi/all_donasi';
    // buat di localhost
    const url = 'http://rumah-harapan.herokuapp.com/donasi/all_donasi';
    try {
      extractedData = [];
      final response = await http.get(Uri.parse(url));
      // print(response.body);
      final jsonData = jsonDecode(response.body);

      for (var data in jsonData) {
        Fields fields = Fields(
            author: data["fields"]["author"],
            title: data["fields"]["title"],
            deskripsi: data["fields"]["deskripsi"],
            linkGambar: data["fields"]["link_gambar"],
            penggalang: data["fields"]["penggalang"],
            penerima: data["fields"]["penerima"],
            target: data["fields"]["target"],
            dueDate: data["fields"]["due_date"],
            linkDonasi: data["fields"]["link_donasi"]);

        AllDonasi donate =
            AllDonasi(fields: fields, model: data["model"], pk: data["pk"]);
        extractedData.add(donate);
      }
      return extractedData;
    } catch (error) {
      print(error);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donasi"),
      ),
      drawer: DrawerScreen(),
      body: Center(
          child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DonasiContainer(isUser: false),
                  SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                    children: [
                      Text("Mari Bantu Sesama #TemanHarapan",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: const Color(0xff59A5D8))),
                      SizedBox(height: 24),
                      FutureBuilder(
                        future: fetchData(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                              child: Center(
                                  child: Text(
                                "Loading...",
                              )),
                            );
                          } else {
                            return CarouselSlider(
                              options: CarouselOptions(height: 388.0),
                              items: extractedData.map((data) {
                                return Builder(builder: (BuildContext context) {
                                    return Container(
                                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                                        child: CardCarousel(data: data, isUser: false));
                                  },
                            );
                            }).toList(),
                          );
                        }
                      }
                    ),
                  ],
                ),
              ),
                SizedBox(
                  width: double.infinity,
                  child: isUser == true
                    ? Container(
                        color: const Color(0xffade8f4),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      textStyle: const TextStyle(fontSize: 20),
                                      primary: const Color(0xffade8f4),
                                      onPrimary: Colors.white,
                                      shadowColor: Colors.transparent,
                                      padding: EdgeInsets.only(
                                          left: 12, right: 12, top: 8, bottom: 8),
                                    ),
                                    onPressed: () {
                                      Route route = MaterialPageRoute(
                                          builder: (context) => AddDonasiForm());
                                      Navigator.push(context, route);
                                    },
                                    child: Text("+ Tambah Donasi",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: const Color(0xff59A5D8))),
                                  )
                                ],
                              ),
                              SizedBox(height: 24),
                              Text("Donasi Saya",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32,
                                      color: const Color(0xff59A5D8))),
                              SizedBox(height: 24),
                              FutureBuilder(
                                  future: fetchData(),
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (snapshot.data == null) {
                                      return Container(
                                        child: Center(
                                            child: Text(
                                          "Loading...",
                                        )),
                                      );
                                    } else {
                                      return CarouselSlider(
                                        options: CarouselOptions(height: 388.0),
                                        items: extractedData.map((data) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                                  child: CardCarousel(
                                                      data: data, isUser: true));
                                            },
                                          );
                                        }).toList(),
                                      );
                                    }
                                  }
                                ),
                              ],
                            ),
                          )
                        )
                  : Column(
                      children: [],
                    )
                ),
              ],
            )
          )
      ),
    );
  }
}
