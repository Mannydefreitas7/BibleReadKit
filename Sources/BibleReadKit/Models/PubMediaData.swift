//
//  PubMediaData.swift
//  
//
//  Created by Manuel De Freitas on 10/9/22.
//

import Foundation

// MARK: - PubMediaItem
public struct PubMediaItem: Codable {
    public let pubName, parentPubName: String?
    public let booknum: Int?
    public let pub, issue, formattedDate: String?
    public let fileformat: [String]?
    public let track: Int?
    public let specialty: String?
    public let pubImage: PubImage?
    public let files: [String: PMFile]?
}

// MARK: - FilesE
public struct PMFile: Codable {
    public let mp3: [PMMp3]?

    enum CodingKeys: String, CodingKey {
        case mp3 = "MP3"
    }
}

// MARK: - Mp3
public struct PMMp3: Codable {
    public let title: String?
    public let file: PubImage?
    public let filesize: Int?
    public let trackImage: PubImage?
    public let markers: Markers?
    public let label: String?
    public let track: Int?
    public let hasTrack: Bool?
    public let pub: String?
    public let docid, booknum: Int?
    public let mimetype, edition, editionDescr, format: String?
    public let formatDescr, specialty, specialtyDescr: String?
    public let subtitled: Bool?
    public let frameWidth, frameHeight, frameRate: Int?
    public let duration, bitRate: Double?
}

// MARK: - PubImage
public struct PubImage: Codable {
    public let url: String?
    public let stream: String?
    public let modifiedDatetime: String?
    public let checksum: String?
}

// MARK: - Markers
public struct Markers: Codable, Hashable {
    public let mepsLanguageSpoken: String?
    public let bibleBookChapter: Int?
    public let mepsLanguageWritten: String?
    public let bibleBookNumber: Int?
    public let markers: [Marker]?
    public let type, hash: String?
    public let introduction: Introduction?
}

// MARK: - Introduction
public struct Introduction: Codable, Hashable {
    public let duration, startTime: String?
}

// MARK: - Marker
public struct Marker: Codable, Hashable {
    public let duration: String?
    public let verseNumber: Int?
    public let startTime: String?
}
