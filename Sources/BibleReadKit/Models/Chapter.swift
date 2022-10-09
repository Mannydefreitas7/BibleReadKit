//
//  Chapter.swift
//  
//
//  Created by Manuel De Freitas on 10/8/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import RealmSwift


// Chapter
public struct BRChapter: Identifiable, Codable, Hashable {
    public static func == (lhs: BRChapter, rhs: BRChapter) -> Bool {
        return lhs.id == rhs.id
    }
    @DocumentID public var id: String?
    public var book: BRBook?
    public var chapterNumber: Int?
    public var uid: String?
    public var verseCount: Int?
    public var verseRange: String?
    public var verses: [BRVerse]?
}

public final class LocalChapter: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) public var id: ObjectId
    @Persisted public var name: String = ""
    @Persisted public var index: Int = 0
    @Persisted public var content: String = ""
    @Persisted public var isRead: Bool = false
    @Persisted(originProperty: "chapters") var book: LinkingObjects<LocalBook>
    @Persisted public var chapterNumber: Int = 0
    @Persisted public var verseCount: Int = 0
    @Persisted public var verseRange: String = ""
    @Persisted public var verses: List<LocalVerse>
}

