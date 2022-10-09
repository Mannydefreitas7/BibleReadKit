//
//  Language.swift
//  Bible Read Admin
//
//  Created by De Freitas, Manuel on 9/15/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import RealmSwift

// Language
public struct BRLanguage: Codable, Hashable {
    @DocumentID public var id: String?
    public var api : String?
    public var audioCode: String?
    public var isRTL: Bool?
    public var locale: String?
    public var name: String?
    public var uid: String?
    public var vernacularName: String?
    public var wolApi: String?
    public var audioApiCode: String?
    @ServerTimestamp public var createdAt: Timestamp?
}

public final class LocalLanguage: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) public var id: ObjectId
    @Persisted public var api: String = ""
    @Persisted public var audioCode: String = ""
    @Persisted public var isRTL: Bool = false
    @Persisted public var locale: String = ""
    @Persisted public var name: String = ""
    @Persisted public var uid: String = ""
    @Persisted public var vernacularName: String = ""
    @Persisted public var audioApiCode: String?
}

public extension BRLanguage {
    
    func mockLanguage() -> BRLanguage {
        
        let language = BRLanguage(id: UUID().uuidString, api: "", audioCode: "E", isRTL: false, locale: "en", name: "English", uid: UUID().uuidString, vernacularName: "English", wolApi: "", createdAt: .init(date: .now))
        return language
    }
    
    func mockLanguages() -> [BRLanguage] {
        
        let ids = [UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString]
        let languages : [BRLanguage] = ids.map { id in
            return  BRLanguage(id: id, api: "", audioCode: "E", isRTL: false, locale: "en", name: "Language", uid: id, vernacularName: id, wolApi: "", createdAt: .init(date: .now))
        }
        return languages
    }
    
    
}
