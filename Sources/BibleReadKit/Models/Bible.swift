//
//  Bible.swift
//  Bible Read Admin
//
//  Created by De Freitas, Manuel on 9/15/22.
//

import Foundation


public struct Bible: Codable, Hashable {
    public static func == (lhs: Bible, rhs: Bible) -> Bool {
        return lhs.uid == rhs.uid
    }
    
    public var uid: String?
    public var name: String?
    public var contentApi: String?
    public var index: Int?
    public var wolApi: String?
    public var symbol: String?
    public var language: Language?
    public var year: String?
    public var books: [Book]?
    public var isUploaded: Bool?
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }
}

public struct Book: Codable {
    public var uid: String?
    public var bookNumber: Int?
    public var name: String?
    public var shortName: String?
    public var chapterCount: Int?
    public var writer: Writer?
    public var type: BookType?
    public var language: Language?
    public var range: String?
    public var isDownloaded: Bool?
    public var bible: Bible?
    public var title: String?
    public var chapters: [Chapter]?
}


public struct Writer: Codable {
    public var uid: String?
    public var name: String?
    public var lifeSpan: String?
    public var date: Date?
    public var image: Data?
}

public struct Chapter: Codable {
    public var uid: String?
    public var chapterNumber: Int?
    public var verseCount: Int?
    public var verses: [Verse]?
    public var book: Book?
    public var verseRange: String?
}

public struct Verse: Codable {
    public var uid: String?
    public var chapter: Int?
    public var verseNumber: Int?
    public var content: String?
}

public enum BookType: String, Codable {
    case greek = "greek"
    case hebrew = "hebrew"
}


public struct DBBible {
    public var bibleTranslation: String?
    public var contentApi: String?
    public var id: String?
    public var index: String?
    public var symbol: String?
}

public struct DBBook {
    public var bookID: Int?
    public var chapterCount: String?
    public var hasAudio: Bool
    public var longName: String?
    public var shortName: String?
}
