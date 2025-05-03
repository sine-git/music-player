import 'package:flutter/material.dart';
import 'package:music_player/components/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // Logo
          DrawerHeader(
              child: Center(
            child: Icon(Icons.music_note,
                size: 40, color: Theme.of(context).colorScheme.inversePrimary),
          ))

          // Home title
          ,
          Padding(
            padding: EdgeInsets.only(left: 25, top: 25),
            child: ListTile(
              title: Text(
                "H O M E",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              leading: Icon(Icons.home,
                  color: Theme.of(context).colorScheme.inversePrimary),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          )
          // Setting title
          ,
          Padding(
            padding: EdgeInsets.only(
              left: 25,
            ),
            child: ListTile(
              title: Text(
                "S E T T I N G S",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              leading: Icon(Icons.settings,
                  color: Theme.of(context).colorScheme.inversePrimary),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ));
              },
            ),
          )
        ],
      ),
    );
  }
}
