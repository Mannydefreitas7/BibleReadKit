//
//  Bible.swift
//  Bible Read Admin
//
//  Created by De Freitas, Manuel on 9/15/22.
//

import Foundation


struct Bible: Codable, Hashable {
    static func == (lhs: Bible, rhs: Bible) -> Bool {
        return lhs.uid == rhs.uid
    }
    
    var uid: String?
    var name: String?
    var contentApi: String?
    var index: Int?
    var wolApi: String?
    var symbol: String?
    var language: Language?
    var year: String?
    var books: [Book]?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }
}

struct Book: Codable {
    var uid: String?
    var bookNumber: Int?
    var name: String?
    var shortName: String?
    var chapterCount: Int?
    var writer: Writer?
    var type: BookType?
    var language: Language?
    var range: String?
    var isDownloaded: Bool?
    var bible: Bible?
    var title: String?
    var chapters: [Chapter]?
}


struct Writer: Codable {
    var uid: String?
    var name: String?
    var lifeSpan: String?
    var date: Date;
    var image: Data?;
}

struct Chapter: Codable {
    var uid: String?
    var chapterNumber: Int?
    var verseCount: Int?
    var verses: [Verse]?
    var book: Book?
    var verseRange: String?
}

struct Verse: Codable {
    var uid: String?
    var chapter: Int?
    var verseNumber: Int?
    var content: String?
}

enum BookType: String, Codable {
    case greek = "greek"
    case hebrew = "hebrew"
}


struct DBBible {
    var bibleTranslation: String?
    var contentApi: String?
    var id: String?
    var index: String?
    var symbol: String?
}

struct DBBook {
    var bookID: Int?
    var chapterCount: String?
    var hasAudio: Bool
    var longName: String?
    var shortName: String?
}
