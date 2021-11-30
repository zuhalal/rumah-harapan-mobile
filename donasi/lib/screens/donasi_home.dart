import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:donasi/widgets/card_carousel.dart';
import 'package:http/http.dart' as http;

class DonasiHome extends StatefulWidget {
  const DonasiHome({Key? key}) : super(key: key);

  @override
  _DonasiHomeState createState() => _DonasiHomeState();
}

class _DonasiHomeState extends State<DonasiHome> {

  List<dynamic> extractedData = [];
  fetchData() async {
    const url = 'http://10.0.2.2:8000/donasi/all_donasi';
    // buat di localhost
    // const url = 'http://rumah-harapan.herokuapp.com/donasi/all_donasi';
    try {
      final response = await http.get(Uri.parse(url));
      // print(response.body);
      extractedData = jsonDecode(response.body);
      print(extractedData);
      return extractedData;
    } catch (error) {
      print(error);
    }
  }

  void didChangeDependencies() {
    fetchData();
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Container(
                color: const Color(0xffade8f4),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Image.asset('assets/images/3724843.png'),
                      Text("Donasi", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: const Color(0xff59A5D8))),
                      SizedBox(height: 24,),
                      Container(
                        child: Text("Mari kita ringankan beban sesama #TemanHarapan di tengah pandemi Covid-19 ini. Kamu dapat membantu dengan berdonasi sesuai dengan keinginan dan keikhlasan kamu. "
                            "Setiap uang yang kamu keluarkan dapat menjadi pintu rezeki bagi mereka yang membutuhkan. ", textAlign: TextAlign.justify, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
                      ),
                      SizedBox(height: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),
                              primary: Colors.black12,
                              onPrimary: Colors.white,
                              side: BorderSide(width: 2,color: const Color(0xff023E8A)),
                              padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),),
                            onPressed: () {},
                            child: const Text('Lihat Donasi Saya'),
                          ),
                          SizedBox(height: 4),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),
                                onPrimary: Colors.white,
                                primary: const Color(0xff023E8A),
                                side: BorderSide(width: 2,color: const Color(0xff023E8A)),
                                padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0))),
                            onPressed: () {
                              fetchData();
                            },
                            child: const Text('Donasi Sekarang'),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
            ),
          ),
          SizedBox(height: 24),
          FutureBuilder(
              future: fetchData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                        child: Text("Loading...",
                        )
                    ),
                  );
                } else {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text("Judul Donasi"),
                          Text(snapshot.data[index]["fields"]["title"].toString()),
                          SizedBox(height: 20,),
                          Text("Deskripsi"),
                          Text(snapshot.data[index]["fields"]["deskripsi"].toString()),
                          SizedBox(height: 20,),
                          Text("Penggalang"),
                          Text(snapshot.data[index]["fields"]["penggalang"].toString()),
                          SizedBox(height: 20,),
                          Text("Penerima"),
                          Text(snapshot.data[index]["fields"]["penerima"].toString()),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: 1,
                      );
                    },
                  );
                }
              }
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text("Mari Bantu Sesama #TemanHarapan",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: const Color(0xff59A5D8))
                ),
                SizedBox(height: 24),
                CarouselSlider(
                  options: CarouselOptions(height: 388.0),
                  items: [1,2,3,4,5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            child: CardCarousel()
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Container(
                color: const Color(0xffade8f4),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("+ Tambah Donasi",
                              textAlign: TextAlign.right,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: const Color(0xff59A5D8))
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Text("Donasi Saya",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: const Color(0xff59A5D8))
                      ),
                      SizedBox(height: 24),
                      CarouselSlider(
                        options: CarouselOptions(height: 388.0),
                        items: [1,2].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                                  child: CardCarousel()
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                )
            ),
          ),
        ],
      )
    );
  }
}
