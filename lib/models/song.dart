// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

class Song {
  final String songName;
  final String artistName;
  final Uint8List? albumArt;
  final String audioPath;
  Song({
    required this.songName,
    required this.artistName,
    required this.albumArt,
    required this.audioPath,
  });
}
