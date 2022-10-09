//
//  Verse.swift
//  
//
//  Created by Manuel De Freitas on 10/8/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import RealmSwift

// Verse
public struct BRVerse: Codable, Hashable {
    public var uid: String?
    public var chapter: Int?
    public var verseNumber: Int?
    public var content: String?
}


public final class LocalVerse: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) public var id: ObjectId
    @Persisted public var chapterNumber: Int = 0
    @Persisted public var uid: String = ""
    @Persisted public var content: String = ""
    @Persisted public var verseNumber: Int = 0
    @Persisted(originProperty: "verses") var chapter: LinkingObjects<LocalChapter>
}
