import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Zuhal 'Alimul Hadi"),
            currentAccountPicture: CircleAvatar(backgroundImage: AssetImage("assets/images/orang.png"),),
            accountEmail: Text("zuhalalimulhadi19@gmail.com"),
          ),
          DrawerListTile(
            iconData: Icons.home,
            title: "Home",
            onTilePressed: () {

            },
          ),
          DrawerListTile(
            iconData: Icons.monetization_on,
            title: "Donasi",
            onTilePressed: () {

            },
          ),
          DrawerListTile(
            iconData: Icons.announcement,
            title: "Publikasi",
            onTilePressed: () {

            },
          ),
          DrawerListTile(
            iconData: Icons.update,
            title: "Update Covid",
            onTilePressed: () {

            },
          ),
          DrawerListTile(
            iconData: Icons.contacts,
            title: "Kontak Penting",
            onTilePressed: () {

            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final IconData iconData ;
  final String title;
  final VoidCallback onTilePressed;
  const DrawerListTile({Key? key, required this.iconData, required this.title, required this.onTilePressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTilePressed,
      dense: true,
      leading: Icon(iconData),
      title: Text(title, style: TextStyle(fontSize: 16),),
    );
  }
}

