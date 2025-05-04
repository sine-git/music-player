import Flutter
import UIKit
import AVFoundation

public class SwiftFlutterMediaMetadataNewPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_media_metadata_new", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterMediaMetadataNewPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "getMetadata" {
            guard let args = call.arguments as? [String: Any],
                  let filePath = args["filePath"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "File path is required", details: nil))
                return
            }

            let metadata = getMetadata(filePath: filePath)
            result(metadata)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    private func getMetadata(filePath: String) -> [String: Any?] {
        let asset = AVURLAsset(url: URL(fileURLWithPath: filePath))
        var metadataDict: [String: Any?] = [:]

        metadataDict["metadata"] = [
            "trackName": getMetadataItem(for: asset, key: .commonKeyTitle),
            "trackArtistNames": getMetadataItem(for: asset, key: .commonKeyArtist)?.split(separator: "/").map { String($0) }.joined(separator: "/"),
            "albumName": getMetadataItem(for: asset, key: .commonKeyAlbumName),
            "albumArtistName": getMetadataItem(for: asset, key: .commonKeyArtist),
            "trackNumber": Int(getMetadataItem(for: asset, key: .commonKeyTrackNumber) ?? ""),
            "albumLength": Int(getMetadataItem(for: asset, key: .commonKeyTrackCount) ?? ""),
            "year": Int(getMetadataItem(for: asset, key: .commonKeyCreationDate)?.split(separator: "-").first ?? ""),
            "genre": getMetadataItem(for: asset, key: .commonKeyGenre),
            "authorName": getMetadataItem(for: asset, key: .commonKeyCreator),
            "writerName": getMetadataItem(for: asset, key: .commonKeyContributor),
            "discNumber": Int(getMetadataItem(for: asset, key: .commonKeyDiscNumber) ?? ""),
            "mimeType": asset.mimeType(),
            "trackDuration": Int(CMTimeGetSeconds(asset.duration) * 1000),  // Duration in milliseconds
            "bitrate": Int(asset.tracks.first?.estimatedDataRate ?? 0)
        ]

        // Extract album art
        if let artworkData = getArtworkData(for: asset) {
            metadataDict["albumArt"] = artworkData
        }

        metadataDict["filePath"] = filePath

        return metadataDict
    }

    private func getMetadataItem(for asset: AVAsset, key: AVMetadataKey) -> String? {
        let metadataItem = asset.commonMetadata.first { $0.commonKey?.rawValue == key.rawValue }
        return metadataItem?.stringValue
    }

    private func getArtworkData(for asset: AVAsset) -> Data? {
        let metadataItem = asset.commonMetadata.first { $0.commonKey?.rawValue == AVMetadataKey.commonKeyArtwork.rawValue }
        return metadataItem?.dataValue
    }
}

extension AVURLAsset {
    func mimeType() -> String {
        let fileExtension = (self.url as NSURL).pathExtension
        if let fileUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension! as CFString, nil)?.takeRetainedValue() {
            if let mimeType = UTTypeCopyPreferredTagWithClass(fileUTI, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimeType as String
            }
        }
        return "application/octet-stream"
    }
}
