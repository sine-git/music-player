import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_media_metadata_new/file_meta_data.dart';

class FlutterMediaMetadataNew {
  static const MethodChannel _channel =
      MethodChannel('flutter_media_metadata_new');

  /// Fetches metadata from the given file path.
  static Future<FileMetaData> getMetadata(String filePath) async {
    // Invoke the method and get the raw metadata map
    final Map<Object?, Object?> rawMetadata =
        await _channel.invokeMethod('getMetadata', {'filePath': filePath});

    // Convert the raw metadata to a Map<String, dynamic>
    final Map<String, dynamic> metadata =
        rawMetadata.map((key, value) => MapEntry(key as String, value));

    // Return the parsed metadata as a FileMetaData object
    return FileMetaData.fromJson(metadata);
  }
}
