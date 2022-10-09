//
//  Bible.swift
//  Bible Read Admin
//
//  Created by De Freitas, Manuel on 9/15/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import RealmSwift

// Bible
public struct BRBible: Codable, Hashable {
    public static func == (lhs: BRBible, rhs: BRBible) -> Bool {
        return lhs.id == rhs.id
    }
    @DocumentID var id: String?
    public var uid: String?
    public var name: String?
    public var contentApi: String?
    public var index: Int?
    public var wolApi: String?
    public var symbol: String?
    public var version: String?
    public var language: BRLanguage?
    public var year: String?
    public var books: [BRBook]?
    public var isUploaded: Bool?
    @ServerTimestamp public var createdAt: Timestamp?
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }
    
}

public final class LocalBible: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) public var id: ObjectId
    @Persisted public var contentApi: String = ""
    @Persisted public var index: Int = 0
    @Persisted public var verseNumber: String = ""
    @Persisted public var name: String = ""
    @Persisted public var symbol: String = ""
    @Persisted public var uid: String = ""
    @Persisted public var wolApi: String = ""
    @Persisted public var books = List<LocalBook>()
    @Persisted public var language: LocalLanguage?
    
}


public extension LocalBible {
    
    func mockLocalBible() -> LocalBible {
        let localBible = LocalBible()
        localBible.uid = UUID().uuidString
        localBible.symbol = "nwt"
        localBible.name = "Bible"
        localBible.contentApi = ""
        localBible.index = 1
        return localBible
    }
    
    func createLocalBible(from bible: BRBible, in language: BRLanguage) -> LocalBible {
        let localBible = LocalBible()
        localBible.uid = bible.uid ?? ""
        localBible.symbol = bible.symbol ?? ""
        localBible.name = bible.name ?? ""
        localBible.contentApi = bible.contentApi ?? ""
        localBible.index =  bible.index ?? 0
        return localBible
    }
}


