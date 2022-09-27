//
//  WOLChapter.swift
//  Bible Read Admin
//
//  Created by Manuel De Freitas on 9/22/22.
//

import Foundation

public struct WOLChapter: Codable {
    let title, content, articleClasses: String
}

// MARK: - WOLLanguages
struct WOLLanguages: Codable {
    let items: [Item]
}

struct WOLVerse: Codable {
    var uid: String?
    var chapter: Int?
    var verseNumber: Int?
    var content: String?
}

// MARK: - Item
struct Item: Codable {
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

enum AppRoot: String, Codable {
    case empty = "/"
}

enum Direction: String, Codable {
    case ltr = "ltr"
    case rtl = "rtl"
}

// MARK: - LIB
struct LIB: Codable {
    let title, researchConfigurationID, symbol: String
    let hasRuby, isPrivileged: Bool
}

