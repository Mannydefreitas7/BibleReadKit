//
//  GetBibleData.swift
//  Bible Read Admin
//
//  Created by Manuel De Freitas on 9/22/22.
//

import Foundation

// MARK: - Akjv
public struct BibleTranslation: Codable {
    let translation, abbreviation, lang, language: String
    let direction, encoding, distributionLcsh, distributionVersion: String
    let distributionVersionDate, distributionAbbreviation, distributionAbout, distributionLicense: String

    enum CodingKeys: String, CodingKey {
        case translation, abbreviation, lang, language, direction, encoding
        case distributionLcsh = "distribution_lcsh"
        case distributionVersion = "distribution_version"
        case distributionVersionDate = "distribution_version_date"
        case distributionAbbreviation = "distribution_abbreviation"
        case distributionAbout = "distribution_about"
        case distributionLicense = "distribution_license"
    }
}


public struct GetBibleBook: Codable {
    let translation, abbreviation, lang, language: String?
    let direction, encoding: String?
    let nr: Int?
    let name: String?
    let chapters: [GetBibleChapter]?
}


// MARK: - GetBibleChapter
public struct GetBibleChapter: Codable {
    let translation, abbreviation, lang, language: String?
    let direction, encoding: String?
    let bookNr: Int?
    let bookName: String?
    let chapter: Int?
    let name: String?
    let verses: [GBVerse]?

    enum CodingKeys: String, CodingKey {
        case translation, abbreviation, lang, language, direction, encoding
        case bookNr = "book_nr"
        case bookName = "book_name"
        case chapter, name, verses
    }
}

// MARK: - Verse
public struct GBVerse: Codable {
    let chapter, verse: Int?
    let name, text: String?
}
