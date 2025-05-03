import 'package:flutter/material.dart';
import 'package:music_player/home_page.dart';
import 'package:music_player/light_mode.dart';
import 'package:music_player/models/play_list_provider.dart';
import 'package:music_player/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => PlayListProvider(),
    )
  ], child: const MusicApp()));
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
