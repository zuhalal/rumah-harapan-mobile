import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:donasi/widgets/card_detail_donasi.dart';

class DonasiDetail extends StatefulWidget {
  const DonasiDetail({Key? key}) : super(key: key);

  @override
  _DonasiDetailState createState() => _DonasiDetailState();
}

class _DonasiDetailState extends State<DonasiDetail> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Author: Zuhal 'Alimul Hadi", textAlign: TextAlign.left, style: TextStyle(fontSize: 20, color: const Color(0xff59A5D8)))
                  ],
                ),
                SizedBox(height: 24),
                Text("Mari Kita Bantu Orang ini", textAlign: TextAlign.center, style: TextStyle(fontSize: 36, color: const Color(0xff59A5D8)),),
                SizedBox(height: 24),
                Image.asset('assets/images/donate.jpg'),
                SizedBox(height: 48),
                Row(
                  children: [
                    Text("Deskripsi", textAlign: TextAlign.left, style: TextStyle(fontSize: 28, color: const Color(0xff59A5D8))),
                  ],
                ),
                SizedBox(height: 16),
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc a nisi fringilla, ultricies sapien id, cursus tortor. In hendrerit tellus nec ligula imperdiet, sed congue ipsum cursus. Nunc vestibulum hendrerit neque in venenatis. Pellentesque eu ipsum iaculis, ullamcorper neque ac, pharetra urna. Praesent eget ullamcorper massa, nec efficitur metus. Duis risus nulla, cursus convallis tortor quis, posuere vulputate erat. Nullam ac ex auctor, imperdiet sem vitae, tincidunt tellus. Etiam posuere tortor vel nulla ultrices, in ultricies dolor faucibus. Phasellus ac neque eget urna euismod cursus quis ac urna. Cras vulputate arcu vel felis pretium, ac tincidunt lacus venenatis. Vestibulum lacinia sit amet urna eget sodales. ",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 48),
                Row(
                  children: [
                    Text("Detail", textAlign: TextAlign.left, style: TextStyle(fontSize: 28, color: const Color(0xff59A5D8))),
                  ],
                ),
                SizedBox(height: 16),
                CardDetailDonasi(icon: Icons.monetization_on, title: "Penggalang Dana:", name: "Zuhal 'Alimul Hadi",),
                SizedBox(height: 24),
                CardDetailDonasi(icon: Icons.people_sharp, title: "Penerima Dana:", name: "Siapa yaa"),
                SizedBox(height: 16),
                CardDetailDonasi(icon: Icons.attach_money, title: "Target:", name: "Rp200.000"),
                SizedBox(height: 24),
                CardDetailDonasi(icon: Icons.calendar_today, title: "Tenggat Waktu:", name: "14 November 2021"),
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
                      child: const Text('Bagikan'),
                    ),
                    SizedBox(height: 4),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),
                          onPrimary: Colors.white,
                          primary: const Color(0xff023E8A),
                          side: BorderSide(width: 2,color: const Color(0xff023E8A)),
                          padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0))),
                      onPressed: () {},
                      child: const Text('Donasi Sekarang'),
                    ),
                  ],
                ),
              ],
            )
        )
    );
  }
}
