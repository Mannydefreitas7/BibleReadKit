//
//  Language.swift
//  Bible Read Admin
//
//  Created by De Freitas, Manuel on 9/15/22.
//

import Foundation

public struct DBLanguage {
    public var api: String?
    public var audioCode: String?
    public var bibleTranslation: String?
    public var bibles: [DBBible]
    public var contentApi: String?
    public var books: [DBBook]?
    public var index: Int?
    public var isRTL: Bool?
    public var locale: String?
    public var name: String?
    public var vernacularName: String?
}
public struct Languages: Codable {
    public var language: [String: Language]?
}
public struct Language: Codable {
    public var name: String?
    public var uid: String?
    public var index: Int?
    public var isRTL: Bool?
    public var locale: String?
    public var wolApi: String?
    public var vernacularName: String?
    public var audioCode: String?
    public var api: String?
    public var bibles: [String: Bible]?
}

public enum LanguageSource {
    case firestore
    case wol
}


public struct WOLLanguage: Codable {
    public let  items: [Item]?
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
