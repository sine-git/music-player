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
  late final _gettingListFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playlistProvider = Provider.of<PlayListProvider>(context, listen: false);
    _gettingListFuture = playlistProvider.getPlayList();
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          "P L A Y L I S T",
        ),
      ),
      drawer: MyDrawer(),
      body: Consumer<PlayListProvider>(
        builder: (context, value, child) => FutureBuilder(
            future: _gettingListFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child:
                        Text("Impossible de récuperer la liste des chansons"));
              } else if (!snapshot.hasData) {
                return Center(
                    child:
                        Text("Impossible de récuperer la liste des chansons"));
              } else
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ListView.builder(
                    itemCount: value.playlist.length,
                    itemBuilder: (context, index) {
                      Song song = value.playlist[index];
                      return ListTile(
                        leading: song.albumArt != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.memory(
                                  song.albumArt!,
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                ),
                              )
                            : Image.asset(
                                '${imagesSourcePath}music_player.webp',
                                width: 50,
                                height: 50,
                              ),
                        title: Text(
                          maxLines: 1,
                          "${song.songName}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              overflow: TextOverflow.ellipsis),
                        ),
                        subtitle: Text("${song.artistName}",
                            maxLines: 1,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                overflow: TextOverflow.ellipsis)),
                        onTap: () {
                          goToSong(index);
                        },
                      );
                    },
                  ),
                );
            }),
      ),
    );
  }
}
