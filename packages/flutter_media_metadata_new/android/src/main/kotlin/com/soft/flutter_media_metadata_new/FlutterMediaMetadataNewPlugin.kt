package com.soft.flutter_media_metadata_new

import android.media.MediaMetadataRetriever
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class FlutterMediaMetadataNewPlugin: FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_media_metadata_new")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getMetadata") {
            val filePath = call.argument<String>("filePath") ?: return
            val metadata = getMetadata(filePath)
            result.success(metadata)
        } else {
            result.notImplemented()
        }
    }

    private fun getMetadata(filePath: String): Map<String, Any?> {
        val retriever = MediaMetadataRetriever()
        retriever.setDataSource(filePath)

        val trackArtistNames = retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_ARTIST)?.split('/') ?: emptyList()

        val albumArt = retriever.embeddedPicture

        return mapOf(
            "metadata" to mapOf(
                "trackName" to retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_TITLE),
                "trackArtistNames" to trackArtistNames.joinToString("/"),
                "albumName" to retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_ALBUM),
                "albumArtistName" to retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_ALBUMARTIST),
                "trackNumber" to retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_CD_TRACK_NUMBER)?.toIntOrNull(),
                "albumLength" to retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_NUM_TRACKS)?.toIntOrNull(),
                "year" to retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_YEAR)?.toIntOrNull(),
                "genre" to retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_GENRE),
                "authorName" to retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_AUTHOR),
                "writerName" to retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_WRITER),
                "discNumber" to retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_DISC_NUMBER)?.toIntOrNull(),
                "mimeType" to retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_MIMETYPE),
                "trackDuration" to retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_DURATION)?.toIntOrNull(),
                "bitrate" to retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_BITRATE)?.toIntOrNull(),
            ),
            "albumArt" to albumArt,
            "filePath" to filePath
        )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
