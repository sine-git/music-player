import 'dart:typed_data';

/// FileMetaData of a media file.
class FileMetaData {
  /// Name of the track.
  final String? trackName;

  /// Names of the artists performing in the track.
  final List<String>? trackArtistNames;

  /// Name of the album.
  final String? albumName;

  /// Name of the album artist.
  final String? albumArtistName;

  /// Position of track in the album.
  final int? trackNumber;

  /// Number of tracks in the album.
  final int? albumLength;

  /// Year of the track.
  final int? year;

  /// Genre of the track.
  final String? genre;

  /// Author of the track.
  final String? authorName;

  /// Writer of the track.
  final String? writerName;

  /// Number of the disc.
  final int? discNumber;

  /// Mime type.
  final String? mimeType;

  /// Duration of the track in milliseconds.
  final int? trackDuration;

  /// Bitrate of the track.
  final int? bitrate;

  /// [Uint8List] containing album art data.
  final Uint8List? albumArt;

  /// File path of the media file.
  final String? filePath;

  const FileMetaData({
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

  /// Factory method to create a [FileMetaData] object from a JSON map.
  factory FileMetaData.fromJson(Map<String, dynamic> map) => FileMetaData(
        trackName: map['metadata']['trackName'] as String?,
        trackArtistNames: map['metadata']['trackArtistNames'] != null
            ? (map['metadata']['trackArtistNames'] as String).split('/')
            : null,
        albumName: map['metadata']['albumName'] as String?,
        albumArtistName: map['metadata']['albumArtistName'] as String?,
        trackNumber: _parseInteger(map['metadata']['trackNumber']),
        albumLength: _parseInteger(map['metadata']['albumLength']),
        year: _parseInteger(map['metadata']['year']),
        genre: map['genre'] as String?,
        authorName: map['metadata']['authorName'] as String?,
        writerName: map['metadata']['writerName'] as String?,
        discNumber: _parseInteger(map['metadata']['discNumber']),
        mimeType: map['metadata']['mimeType'] as String?,
        trackDuration: _parseInteger(map['metadata']['trackDuration']),
        bitrate: _parseInteger(map['metadata']['bitrate']),
        albumArt: map['albumArt'] as Uint8List?,
        filePath: map['filePath'] as String?,
      );

  /// Converts the [FileMetaData] object to a JSON map.
  Map<String, dynamic> toJson() => {
        'trackName': trackName,
        'trackArtistNames': trackArtistNames,
        'albumName': albumName,
        'albumArtistName': albumArtistName,
        'trackNumber': trackNumber,
        'albumLength': albumLength,
        'year': year,
        'genre': genre,
        'authorName': authorName,
        'writerName': writerName,
        'discNumber': discNumber,
        'mimeType': mimeType,
        'trackDuration': trackDuration,
        'bitrate': bitrate,
        'filePath': filePath,
      };

  /// Parses a dynamic value to an integer.
  static int? _parseInteger(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  @override
  String toString() => toJson().toString();
}
