//
//  File.swift
//  
//
//  Created by Manuel De Freitas on 10/8/22.
//

import Foundation
import RealmSwift

// Book
public struct BRBook: Identifiable, Codable, Hashable {
    public static func == (lhs: BRBook, rhs: BRBook) -> Bool {
        return lhs.id == rhs.id
    }
    
    public var id: String?
    public var bookNumber: Int?
    public var uid: String?
    public var chapterCount: Int?
    public var name: String?
    public var range: String?
    public var shortName: String?
    public var title: String?
    public var writer: BRWriter?
    public var isDownloaded: Bool = false
    public var type: BRBookType.RawValue?
    public var bible: BRBible?
    public var language: BRLanguage?
    public var chapters: [BRChapter]?
}


public final class LocalBook: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) public var id: ObjectId
    @Persisted var bookNumber: Int = 0
    @Persisted var chapterCount: Int = 0
    @Persisted var name: String = ""
    @Persisted var range: String = ""
    @Persisted var shortName: String = ""
    @Persisted var title: String = ""
    @Persisted var type: LocalBookType?
    @Persisted var chapters: List<LocalChapter>
    @Persisted var language: LocalLanguage?
    @Persisted(originProperty: "books") var bible: LinkingObjects<LocalBible>
}

public enum BRBookType: String, Codable {
    case greek = "greek"
    case hebrew = "hebrew"
}

public enum LocalBookType: String, PersistableEnum {
    case hebrew
    case greek
}

public extension BRBook {
    func mockBRBook() -> BRBook {
        var book = BRBook()
        book.language = BRLanguage().mockLanguage()
        book.bible =  BRBible().mockBRBible()
        book.id = UUID().uuidString
        book.title = "Genesis"
        book.bookNumber = 1
        book.type = BRBookType.hebrew.rawValue
        book.name = "Genesis"
        book.shortName = "Ge"
        return book
    }
}
