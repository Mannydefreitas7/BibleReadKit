//
//  JWBibleData.swift
//  Bible Read Admin
//
//  Created by Manuel De Freitas on 9/20/22.
//

import Foundation

public struct JWBibleData: Codable {
  public  let status: Int?
  public  let currentLocale: String?
  public  let editionData: EditionData
}



// MARK: - EditionData
public struct EditionData: Codable {
  public  let locale, bookCount, vernacularFullName: String?
  public  let vernacularShortName: String?
   public let vernacularAbbreviation, url, titleFormat, pageCSSClassNames: String?
   public let articleCSSClassNames: String?
  public  let books: [String: JWBook]?
}

// MARK: - Book
public struct JWBook: Codable {
  public  let chapterCount, standardName, standardAbbreviation, officialAbbreviation: String?
  public  let standardSingularBookName, standardSingularAbbreviation, officialSingularAbbreviation, standardPluralBookName: String?
  public  let standardPluralAbbreviation, officialPluralAbbreviation, bookDisplayTitle, chapterDisplayTitle: String?
  public  let urlSegment, url: String?
  public  let hasAudio, hasMultimedia, hasStudyNotes: Bool?
}


// MARK: - JWLibrary
public struct JWLibrary: Codable {
  public  let status: Int
  public  let currentLocale: String
  public  let langs: [String: LangValue]
}

// MARK: - LangValue
public struct LangValue: Codable {
  public  let lang: LangLang
  public  let editions: [Edition]
}

// MARK: - Edition
public struct Edition: Codable {
 public   let title: String
 public   let symbol: Symbol
 public   let contentAPI: String?
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
  public  let symbol, langcode, name, vernacularName: String
  public  let script: String
}

// MARK: - JWRange
public struct JWRange: Codable {
  public  let status: Int
  public  let currentLocale: String
  public  let ranges: [String: Range]
}

public struct Range: Codable {
  public  let citation: String
   public let link: String
 public   let validRange, citationVerseRange: String
 public   let verses: [JWVerse]
  public  let numTranslations: Int
}

// MARK: - Verse
public struct JWVerse: Codable {
  public  let vsID: String
  public  let bookNumber, chapterNumber, verseNumber: Int
  public  let standardCitation, abbreviatedCitation, content: String
}
