import 'package:flutter/material.dart';
import 'package:dyeac/page/profile_page.dart';
import 'package:dyeac/page/login_page.dart';
import 'package:dyeac/page/treatment_history.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('flutter.com'),
            accountEmail: Text('example@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://media.discordapp.net/attachments/718365476492673076/918046188798881812/iu-makeup-hairstyle-strawberry-moon-4.png?width=1196&height=670',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://media.discordapp.net/attachments/718365476492673076/918040881511149578/241189733_399584374869109_3841373067954994690_n.png'),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(Icons.account_box_rounded),
            title: Text('ข้อมูลของฉัน'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ProfilePageWidget()),
            ),
          ),
          ListTile(
            leading: Icon(Icons.table_view_rounded),
            title: Text('ตารางการนัดหมาย'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => TreatmentHistoryWidget()),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout_rounded),
            title: Text('ลงชื่อออก'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => LoginWidget()),
            ),
          )
        ],
      ),
    );
  }
}
