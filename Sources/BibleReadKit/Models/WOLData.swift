//
//  WOLChapter.swift
//  Bible Read Admin
//
//  Created by Manuel De Freitas on 9/22/22.
//

import Foundation

public struct WOLChapter: Codable {
    public let title, content, articleClasses: String
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
    let languageTitle, englishName, asciiEnglishName, vernacularName: String
    let asciiVernacularName, mepsSymbol, mepsScript: String
    let isScriptVariant: Bool
    let direction: Direction
    let isSignLanguage: Bool
    let locale: String
    let ietfLocales: [String]
    let appRoot: AppRoot
    let libLangClasses, libLangAttributes: String
    let libs: [LIB]
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
    let title, researchConfigurationID, symbol: String
    let hasRuby, isPrivileged: Bool
}

