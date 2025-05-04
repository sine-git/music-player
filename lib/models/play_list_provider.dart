import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata_new/flutter_media_metadata_new.dart';
import 'package:music_player/models/song.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

final String imagesSourcePath = "assets/album-covers/";
final String audiosSourcePath = "audios/";

class PlayListProvider extends ChangeNotifier {
  // Playlist of songs

  List<Song> _playlist = [];
/*   final List<Song> _playlist = [
    // Song 1
    Song(
        songName: "Smooth Criminal",
        artistName: "Micheal Jackson",
        albumArtImagePath: "${imagesSourcePath}micheal_jackson_bad.jpg",
        audioPath: "${audiosSourcePath}smooth-criminal.mp3"),
    // Song 2
    Song(
        songName: "Thriller",
        artistName: "Micheal Jackson",
        albumArtImagePath: "${imagesSourcePath}micheal_jackson_thriller.jpeg",
        audioPath: "${audiosSourcePath}smooth-criminal.mp3"),
    // Song 3
    Song(
        songName: "The way you make me feel",
        artistName: "Micheal Jackson",
        albumArtImagePath: "${imagesSourcePath}micheal_jackson_bad.jpg",
        audioPath: "${audiosSourcePath}smooth-criminal.mp3"),
  ]; */

  // Current song playing index

  int? _currentSongIndex;

  /* G E T T E R S */

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  /* S E T T E R S */

  set currentSongIndex(int? newIndex) {
    // Update the new index
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play(); // Play the song at the new index
    }
    // Update UI
    notifyListeners();
  }

  /* A U D I O P L A Y E R */

  // Audio player
  final AudioPlayer _audioPlayer = AudioPlayer();
  // Durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // Constructor

  PlayListProvider() {
    listenToDuration();
  }
  // Initiality not playing
  bool _isPlaying = false;

  // Play the song

  Future<void> getPlayList(BuildContext context) async {
    _playlist = [];
    var permission = await Permission.audio.request();
    if (permission.isGranted) {
      await getMp3Files();
      if (_playlist.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Sorry no music found...."),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Close"))
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Permission denied"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Close"))
          ],
        ),
      );
    }
  }

  Future<List<FileSystemEntity>> getMp3Files() async {
    // Getting the root directory for android
    Directory directory = Directory('/storage/emulated/0/Download');

    List<FileSystemEntity> mp3Files = [];

    // Checking if the directory exist

    final exist = await directory.exists();

    if (!exist) {
      print("......The directory in which songs  should be does not exist");
      return [];
    }
    print("......Does the directory exist? ${await directory.exists()}");

    // Going throw the list of directories and subdirectories
    await for (var entity
        in directory.list(followLinks: false, recursive: true)) {
      // Checking if the file type is mp3
      if (entity is File && entity.path.endsWith(".mp3")) {
        print(".....Music found and is ${entity.path}");
        /*  String songName =
            entity.path.replaceAll("/storage/emulated/0/Download/", ""); */

        // Trying to song metadatas such as the name of the artist, and the album photo
        final metaData = await FlutterMediaMetadataNew.getMetadata(entity.path);

        final songName = metaData.trackName ??
            entity.path.replaceAll("/storage/emulated/0/Download/", "");
        final artistName = metaData.authorName ?? songName;

        // Getting the song album art or use the default one on the UI
        final Uint8List? albumArth = metaData.albumArt;
        final File songFile = File('${imagesSourcePath}music_player.webp');

        // Adding the found file to the playlist
        playlist.add(
          Song(
              songName: songName,
              artistName: artistName,
              albumArt: albumArth,
              audioPath: entity.path),
        );
      }
      notifyListeners();
    }

    return [];
  }

  void play() async {
    final String path = _playlist[currentSongIndex!].audioPath;
    print("The music audio path is $path");
    await _audioPlayer.stop(); // Stop the current song
    await _audioPlayer.play(DeviceFileSource(path));
    //await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  // Pause current song
  void pause() async {
    final String path = _playlist[currentSongIndex!].audioPath;
    await _audioPlayer.pause(); // Stop the current song
    _isPlaying = false;
    notifyListeners();
  }

  // Resume playing
  void resume() async {
    final String path = _playlist[currentSongIndex!].audioPath;
    await _audioPlayer.resume(); // Stop the current song
    _isPlaying = true;
    notifyListeners();
  }

  // Pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
  }

  // Seek to a specific position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // Play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        // got to the next song if it's not the last song
        currentSongIndex = _currentSongIndex! + 1;
      }
    }
  }
  // Play previous song

  void playPreviousSong() {
    // If more than 2 seconds have passed, restart the current song
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    }
    // If it's within first 2 second of the song, go to previous song

    else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        // If it's the first song, loop back to last song
        currentSongIndex = _playlist.length - 1;
      }
    }
  }
  // Listen to duration

  void listenToDuration() {
    // Listen for total duration
    _audioPlayer.onDurationChanged.listen(
      (newDuration) {
        _totalDuration = newDuration;
        notifyListeners();
      },
    );
    // Listen for current duration
    _audioPlayer.onPositionChanged.listen(
      (newPosition) {
        _currentDuration = newPosition;
        notifyListeners();
      },
    );
    // Listen for song completion

    _audioPlayer.onPlayerComplete.listen(
      (event) {
        playNextSong();
      },
    );
  }
}
