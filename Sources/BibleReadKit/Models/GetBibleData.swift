//
//  GetBibleData.swift
//  Bible Read Admin
//
//  Created by Manuel De Freitas on 9/22/22.
//

import Foundation

// MARK: - Akjv
public struct BibleTranslation: Codable {
   public let translation, abbreviation, lang, language: String
   public let direction, encoding, distributionLcsh, distributionVersion: String
   public let distributionVersionDate, distributionAbbreviation, distributionAbout, distributionLicense: String

   public enum CodingKeys: String, CodingKey {
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
   public let translation, abbreviation, lang, language: String?
   public let direction, encoding: String?
   public let nr: Int?
   public let name: String?
   public let chapters: [GetBibleChapter]?
}


// MARK: - GetBibleChapter
public struct GetBibleChapter: Codable {
   public let translation, abbreviation, lang, language: String?
   public let direction, encoding: String?
   public let bookNr: Int?
   public let bookName: String?
   public let chapter: Int?
   public let name: String?
   public let verses: [GBVerse]?

   public enum CodingKeys: String, CodingKey {
        case translation, abbreviation, lang, language, direction, encoding
        case bookNr = "book_nr"
        case bookName = "book_name"
        case chapter, name, verses
    }
}

// MARK: - Verse
public struct GBVerse: Codable {
    public let chapter, verse: Int?
    public let name, text: String?
}
