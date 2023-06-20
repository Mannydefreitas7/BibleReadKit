//
//  Writer.swift
//  
//
//  Created by Manuel De Freitas on 10/8/22.
//

import Foundation
import RealmSwift


// Writer
public struct BRWriter: Codable, Hashable {
    public var id: String?
    public var uid: String?
    public var name: String?
    public var lifeSpan: String?
    public var date: Date?
    public var image: Data?
}

public final class LocalWriter: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) public var id: ObjectId
    public var uid: String?
    public var name: String?
    public var lifeSpan: String?
    public var date: Date?
    public var image: Data?
}
