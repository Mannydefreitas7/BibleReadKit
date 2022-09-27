//
//  Language.swift
//  Bible Read Admin
//
//  Created by De Freitas, Manuel on 9/15/22.
//

import Foundation

struct DBLanguage {
    var api: String?
    var audioCode: String?
    var bibleTranslation: String?
    var bibles: [DBBible]
    var contentApi: String?
    var books: [DBBook]?
    var index: Int?
    var isRTL: Bool?
    var locale: String?
    var name: String?
    var vernacularName: String?
}
struct Languages: Codable {
    var language: [String: Language]?
}
struct Language: Codable {
    var name: String?
    var uid: String?
    var index: Int?
    var isRTL: Bool?
    var locale: String?
    var wolApi: String?
    var vernacularName: String?
    var audioCode: String?
    var api: String?
    var bibles: [String: Bible]?
}

enum LanguageSource {
    case firestore
    case wol
}


struct WOLLanguage: Codable {
    let items: [Item]?
}

// MARK: - Item
struct Item: Codable {
    let languageTitle, englishName, asciiEnglishName, vernacularName: String?
    let asciiVernacularName, mepsSymbol, mepsScript: String?
    let isScriptVariant: Bool?
    let direction: Direction?
    let isSignLanguage: Bool?
    let locale: String?
    let ietfLocales: [String]?
    let appRoot: AppRoot?
    let libLangClasses, libLangAttributes: String?
    let libs: [LIB]?
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
    let title, researchConfigurationID, symbol: String?
    let hasRuby, isPrivileged: Bool?
}
