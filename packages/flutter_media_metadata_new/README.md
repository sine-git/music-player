# flutter_media_metadata_new

`flutter_media_metadata_new` is a Flutter package that allows you to extract media metadata (such as track name, artist, album, duration, etc.) from audio and video files on both Android and iOS platforms.

## Features

- Retrieve media metadata like track name, artist names, album name, and more.
- Access album art as `Uint8List` for display.
- Get file information such as duration, bitrate, and MIME type.
- Platform-specific implementations for Android and iOS using native APIs.

## Installation

Add `flutter_media_metadata_new` to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_media_metadata_new: ^0.0.1
```

Then, run flutter pub get to install the package.

Usage
1. **Import the Package**
```dart
import 'package:flutter_media_metadata_new/flutter_media_metadata_new.dart';
```
2. **Extract Metadata from a Media File**
You can extract metadata from a media file by calling FlutterMediaMetadataNew.getMetadata with the file path:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata_new/flutter_media_metadata_new.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FileMetaData? fileMetadata;

  @override
  void initState() {
    super.initState();
    loadMetadata();
  }

  Future<void> loadMetadata() async {
    final path = '/path/to/your/media/file.mp3'; // Provide the path to your media file
    final fileMetadata = await FlutterMediaMetadataNew.getMetadata(path);
    setState(() {
      this.fileMetadata = fileMetadata;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Media Metadata Example'),
        ),
        body: Center(
          child: fileMetadata == null
              ? CircularProgressIndicator()
              : Text('Track Name: ${fileMetadata!.trackName}\n'
                  'Artist: ${fileMetadata!.trackArtistNames?.join(", ")}\n'
                  'Album: ${fileMetadata!.albumName}'),
        ),
      ),
    );
  }
}
```
3. **FileMetaData Model**
   The FileMetaData class contains various fields for the media information:
```dart
class FileMetaData {
  final String? trackName;
  final List<String>? trackArtistNames;
  final String? albumName;
  final String? albumArtistName;
  final int? trackNumber;
  final int? albumLength;
  final int? year;
  final String? genre;
  final String? authorName;
  final String? writerName;
  final int? discNumber;
  final String? mimeType;
  final int? trackDuration;
  final int? bitrate;
  final Uint8List? albumArt;
  final String? filePath;

  FileMetaData({
    this.trackName,
    this.trackArtistNames,
    this.albumName,
    this.albumArtistName,
    this.trackNumber,
    this.albumLength,
    this.year,
    this.genre,
    this.authorName,
    this.writerName,
    this.discNumber,
    this.mimeType,
    this.trackDuration,
    this.bitrate,
    this.albumArt,
    this.filePath,
  });
}
```
# Example Metadata Fields:
* trackName: The name of the track.
* trackArtistNames: A list of artist names.
* albumName: The name of the album.
* albumArtistName: The name of the album artist.
* trackNumber: The position of the track in the album.
* albumLength: The number of tracks in the album.
* year: The year the track was released.
* genre: The genre of the track.
* authorName: The author of the track.
* writerName: The writer of the track.
* discNumber: The disc number in a multi-disc set.
* mimeType: The MIME type of the file.
* trackDuration: The duration of the track in milliseconds.
* bitrate: The bitrate of the track.
* albumArt: The album art as a Uint8List.
* filePath: The file path of the media file.

#   Platform-Specific Details

**Android**
The package uses MediaMetadataRetriever to extract metadata from media files.

**iOS**
The package uses AVFoundation to extract metadata from media files.