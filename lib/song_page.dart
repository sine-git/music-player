import 'package:flutter/material.dart';
import 'package:music_player/components/drawer.dart';
import 'package:music_player/models/neu_box.dart';
import 'package:music_player/models/play_list_provider.dart';
import 'package:music_player/models/song.dart';
import 'package:music_player/theme_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  late final PlayListProvider playlistProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playlistProvider = Provider.of<PlayListProvider>(context, listen: false);
  }

  // Convert duration int min:sec
  String formatTime(Duration duration) {
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime =
        "${duration.inMinutes.toString().padLeft(2, '0')}:${twoDigitSeconds}";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(builder: (context, value, child) {
      // Get the playlist
      final playList = value.playlist;
      // Get the current song
      final currentSong = playList[value.currentSongIndex ?? 0];
      return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            iconTheme: Theme.of(context).iconTheme,
            centerTitle: true,
            title: Text(
              currentSong.songName,
            ),
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                children: [
                  // Album Artwork
                  NeuBox(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Column(
                          children: [
                            currentSong.albumArt != null
                                ? Image.memory(
                                    currentSong.albumArt!,
                                    fit: BoxFit.cover,
                                    height: MediaQuery.of(context).size.width *
                                        0.65,
                                    width: double.infinity,
                                  )
                                : Image.asset(
                                    '${imagesSourcePath}music_player.webp',
                                    fit: BoxFit.cover,
                                    height: MediaQuery.of(context).size.width *
                                        0.65,
                                    width: double.infinity,
                                  ),
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 20),
                                child: ListTile(
                                  title: Text(
                                    currentSong.songName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Text(
                                    currentSong.artistName,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )

                                /* Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Song and artist name
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentSong.songName,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        currentSong.artistName,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  )
                                  // Heart Icon
                                  ,
                                  GestureDetector(
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ), */
                                ),
                          ],
                        )),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 0, left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Start time
                            Text("${formatTime(value.currentDuration)}"),
                            // Shuffle Icon
                            Icon(
                              Icons.shuffle,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                            // Repeat Icon
                            Icon(Icons.repeat,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
                            // End time
                            Text("${formatTime(value.totalDuration)}")
                          ],
                        ),
                      ),
                      // Song duration progress
                      SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                              trackShape: RectangularSliderTrackShape(),
                              thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: 0,
                              )),
                          child: Padding(
                            padding: EdgeInsets.zero,
                            child: Slider(
                              min: 0,
                              max: value.totalDuration.inSeconds.toDouble(),
                              value: value.currentDuration.inSeconds.toDouble(),
                              activeColor: Colors.green,
                              onChanged: (duration) {
                                // during when the user is dragging the slidder
                              },
                              onChangeEnd: (duration) {
                                // sliding is finished, go to the position
                                value.seek(Duration(seconds: duration.toInt()));
                              },
                            ),
                          ))
                    ],
                  )

                  // Playback controls
                  ,
                  Row(
                    children: [
                      // Skip previous
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playPreviousSong,
                          child: NeuBox(
                            child: Icon(Icons.skip_previous,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),

                      // Play pause
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: value.pauseOrResume,
                          child: NeuBox(
                            child: Icon(
                                value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playNextSong,
                          child: NeuBox(
                            child: Icon(Icons.skip_next,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
                          ),
                        ),
                      ),

                      // Skip forward
                    ],
                  )
                ],
              ),
            ),
          ));
    });
  }
}
