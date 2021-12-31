import 'package:artikel/artikel_screens/detail_artikel.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  CardWidget(this.author, this.title, this.body, this.date);
  final author;
  final title;
  final body;
  final date;

  Widget build(BuildContext context) {
      return Container(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffade8f4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(author),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 18,
                    ),
                    Text(date),
                  ],
                ),
                Text(title),
                SizedBox(height: 10),
                Text(body),
                SizedBox(height: 10),

                // ElevatedButton(
                //                 style: ElevatedButton.styleFrom(
                //                     textStyle: const TextStyle(fontSize: 20),
                //                     onPrimary: Colors.white,
                //                     primary: const Color(0xff023E8A),
                //                     side: BorderSide(
                //                         width: 2,
                //                         color: const Color(0xff023E8A)),
                //                     padding: EdgeInsets.only(
                //                         left: 12, right: 12, top: 8, bottom: 8),
                //                     shape: new RoundedRectangleBorder(
                //                         borderRadius:
                //                             new BorderRadius.circular(8.0))),
                //                 onPressed: () {
                //                   Route route = MaterialPageRoute(
                //                       builder: (context) => DetailArtikel();
                //                   Navigator.push(context, route);
                //                 },
                //                 child: const Text('Lihat Detail'),
                //               ),
              ],
            ),
          ),
        ),
      ),
    );
    }
  }
