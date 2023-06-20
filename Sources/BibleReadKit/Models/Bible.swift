//
//  Bible.swift
//  Bible Read Admin
//
//  Created by De Freitas, Manuel on 9/15/22.
//

import Foundation
import RealmSwift

// Bible
public struct BRBible: Codable, Hashable {
    public static func == (lhs: BRBible, rhs: BRBible) -> Bool {
        return lhs.id == rhs.id
    }
    public var id: String?
    public var uid: String?
    public var name: String?
    public var contentApi: String?
    public var index: Int?
    public var wolApi: String?
    public var symbol: String?
    public var version: Int?
    public var language: BRLanguage?
    public var year: String?
    public var books: [BRBook]?
    public var isUploaded: Bool?
    public var bibleAudioApiSymbol: String?
    public var createdAt: Date?
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }
    
}

public final class LocalBible: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) public var id: ObjectId
    @Persisted public var contentApi: String = ""
    @Persisted public var index: Int = 0
    @Persisted public var verseNumber: String = ""
    @Persisted public var version: Int?
    @Persisted public var name: String = ""
    @Persisted public var symbol: String = ""
    @Persisted public var uid: String = ""
    @Persisted public var wolApi: String = ""
    @Persisted public var books = List<LocalBook>()
    @Persisted public var language: LocalLanguage?
    @Persisted public var languageCode: String?
    @Persisted public var bibleAudioApiSymbol: String?
    
}

public extension BRBible {
    func mockBRBible() -> BRBible {
        var bible = BRBible()
        bible.uid = UUID().uuidString
        bible.symbol = "nwt"
        bible.name = "Bible"
        bible.contentApi = "jw.org"
        bible.index = 1
        bible.language = BRLanguage().mockLanguage()
        return bible
    }
}


public extension LocalBible {
    
   static func mockLocalBible() -> LocalBible {
        let localBible = LocalBible()
        localBible.uid = UUID().uuidString
        localBible.symbol = "nwt"
        localBible.name = "Bible"
        localBible.contentApi = ""
        localBible.index = 1
        return localBible
    }
    
   static func createLocalBible(from bible: BRBible, in language: BRLanguage) -> LocalBible {
        let localBible = LocalBible()
        localBible.uid = bible.uid ?? ""
        localBible.symbol = bible.symbol ?? ""
        localBible.name = bible.name ?? ""
        localBible.contentApi = bible.contentApi ?? ""
        localBible.index =  bible.index ?? 0
        return localBible
    }
}


