//
//  JWBibleData.swift
//  Bible Read Admin
//
//  Created by Manuel De Freitas on 9/20/22.
//

import Foundation

public struct JWBibleData: Codable {
    let status: Int?
    let currentLocale: String?
    let editionData: EditionData
}



// MARK: - EditionData
public struct EditionData: Codable {
    let locale, bookCount, vernacularFullName: String?
    let vernacularShortName: String?
    let vernacularAbbreviation, url, titleFormat, pageCSSClassNames: String?
    let articleCSSClassNames: String?
    let books: [String: JWBook]?
}

// MARK: - Book
public struct JWBook: Codable {
    let chapterCount, standardName, standardAbbreviation, officialAbbreviation: String?
    let standardSingularBookName, standardSingularAbbreviation, officialSingularAbbreviation, standardPluralBookName: String?
    let standardPluralAbbreviation, officialPluralAbbreviation, bookDisplayTitle, chapterDisplayTitle: String?
    let urlSegment, url: String?
    let hasAudio, hasMultimedia, hasStudyNotes: Bool?
}


// MARK: - JWLibrary
public struct JWLibrary: Codable {
    let status: Int
    let currentLocale: String
    let langs: [String: LangValue]
}

// MARK: - LangValue
public struct LangValue: Codable {
    let lang: LangLang
    let editions: [Edition]
}

// MARK: - Edition
public struct Edition: Codable {
    let title: String
    let symbol: Symbol
    let contentAPI: String?
}

public enum Symbol: String, Codable {
    case bi10 = "bi10"
    case bi12 = "bi12"
    case bi22 = "bi22"
    case bifgn = "bifgn"
    case bimt = "bimt"
    case by = "by"
    case int = "int"
    case nwt = "nwt"
    case nwths = "nwths"
    case nwtsty = "nwtsty"
    case rh = "rh"
    case sbi1 = "sbi1"
    case sbi2 = "sbi2"
}

// MARK: - LangLang
public struct LangLang: Codable {
    let symbol, langcode, name, vernacularName: String
    let script: String
}

// MARK: - JWRange
public struct JWRange: Codable {
    let status: Int
    let currentLocale: String
    let ranges: [String: Range]
}

public struct Range: Codable {
    let citation: String
    let link: String
    let validRange, citationVerseRange: String
    let verses: [JWVerse]
    let numTranslations: Int
}

// MARK: - Verse
public struct JWVerse: Codable {
    let vsID: String
    let bookNumber, chapterNumber, verseNumber: Int
    let standardCitation, abbreviatedCitation, content: String
}
