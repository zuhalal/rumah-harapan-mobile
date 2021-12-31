import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CardWidget extends StatelessWidget {
  CardWidget(this.nama, this.kritikSaran, this.waktuPost);
  final nama;
  final kritikSaran;
  final waktuPost;

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
                Text(nama,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 18,
                    ),
                    Text(DateTime.parse(waktuPost).toString()),
                  ],
                ),
                Icon(
                  Icons.format_quote,
                  size: 50,
                  color: const Color(0xff023E8A),
                ),
                Text(kritikSaran),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
