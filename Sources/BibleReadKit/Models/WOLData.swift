//
//  WOLChapter.swift
//  Bible Read Admin
//
//  Created by Manuel De Freitas on 9/22/22.
//

import Foundation

public struct WOLChapter: Codable {
    public let title, content, articleClasses: String
    public let mp3: PMFile?
}

// MARK: - WOLLanguages
public struct WOLLanguages: Codable {
     let items: [Item]
}

public struct WOLVerse: Codable {
    public var uid: String?
    public var chapter: Int?
    public var verseNumber: Int?
    public var content: String?
}


// MARK: - Item
public struct Item: Codable {
    public let  languageTitle, englishName, asciiEnglishName, vernacularName: String?
    public let  asciiVernacularName, mepsSymbol, mepsScript: String?
    public let  isScriptVariant: Bool?
    public let  direction: Direction?
    public let  isSignLanguage: Bool?
    public let  locale: String?
    public let  ietfLocales: [String]?
    public let  appRoot: AppRoot?
    public let  libLangClasses, libLangAttributes: String?
    public let  libs: [LIB]?
}

public enum AppRoot: String, Codable {
    case empty = "/"
}

public enum Direction: String, Codable {
    case ltr = "ltr"
    case rtl = "rtl"
}

// MARK: - LIB
public struct LIB: Codable {
    public let  title, researchConfigurationID, symbol: String?
    public let  hasRuby, isPrivileged: Bool?
}
