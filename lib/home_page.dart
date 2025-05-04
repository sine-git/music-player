import 'package:flutter/material.dart';
import 'package:music_player/components/drawer.dart';
import 'package:music_player/models/play_list_provider.dart';
import 'package:music_player/models/song.dart';
import 'package:music_player/song_page.dart';
import 'package:music_player/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PlayListProvider playlistProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playlistProvider = Provider.of<PlayListProvider>(context, listen: false);
  }

  void goToSong(int songIndex) {
    // Update the current index
    playlistProvider.currentSongIndex = songIndex;

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SongPage(),
        ));
    //
  }

  @override
  Widget build(BuildContext context) {
    playlistProvider.getPlayList(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text("P L A Y L I S T"),
      ),
      drawer: MyDrawer(),
      body: Consumer<PlayListProvider>(
        builder: (context, value, child) => ListView.builder(
          itemCount: value.playlist.length,
          itemBuilder: (context, index) {
            Song song = value.playlist[index];
            return ListTile(
              leading: song.albumArt != null
                  ? Image.memory(
                      song.albumArt!,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      '${imagesSourcePath}music_player.webp',
                    ),
              title: Text(
                "${song.songName}",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              subtitle: Text("${song.artistName}",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary)),
              onTap: () {
                goToSong(index);
              },
            );
          },
        ),
      ),
    );
  }
}
