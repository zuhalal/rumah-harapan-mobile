import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(
      String title, IconData icon, void Function() tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Color.fromRGBO(89, 165, 216, 1),
            child: Text(
              "Rumah Harapan 🏠",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile('Home', Icons.home, () {
            Navigator.pushNamed(context, '/tabs_screen');
          }),
          buildListTile('Donasi', Icons.volunteer_activism, () {
            Navigator.pushNamed(context, '/donasi');
          }),
          buildListTile('Publikasi', Icons.announcement, () {
            Navigator.pop(context);
          }),
          buildListTile('Update Covid', Icons.update, () {
            Navigator.pushNamed(context, '/updateCovid');
          }),
          buildListTile('Kontak Penting', Icons.contacts, () {
            Navigator.pushNamed(context, '/kontak');
          }),
          buildListTile('Kritik Saran', Icons.phone_in_talk, () {
            Navigator.pushNamed(context, '/kritik_saran');
          }),
          buildListTile('Login', Icons.login, () {
            Navigator.pop(context);
            Navigator.pushNamed(context, "/login_screen");
          }),
        ],
      ),
    );
  }
}
