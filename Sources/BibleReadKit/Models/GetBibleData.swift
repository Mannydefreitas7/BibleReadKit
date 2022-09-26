//
//  GetBibleData.swift
//  Bible Read Admin
//
//  Created by Manuel De Freitas on 9/22/22.
//

import Foundation

public struct GetBibleBook: Codable {
    let translation, abbreviation, lang, language: String
    let direction, encoding: String
    let nr: Int
    let name: String
    let chapters: [GetBibleChapter]
}


// MARK: - GetBibleChapter
public struct GetBibleChapter: Codable {
    let translation, abbreviation, lang, language: String?
    let direction, encoding: String?
    let bookNr: Int?
    let bookName: String?
    let chapter: Int?
    let name: String?
    let verses: [GBVerse]

    enum CodingKeys: String, CodingKey {
        case translation, abbreviation, lang, language, direction, encoding
        case bookNr = "book_nr"
        case bookName = "book_name"
        case chapter, name, verses
    }
}

// MARK: - Verse
public struct GBVerse: Codable {
    let chapter, verse: Int
    let name, text: String
}
