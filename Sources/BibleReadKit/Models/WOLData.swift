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
