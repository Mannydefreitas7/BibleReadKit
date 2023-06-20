//
//  BRMP3File.swift
//  
//
//  Created by Manuel De Freitas on 10/9/22.
//

import Foundation
import RealmSwift


// Chapter
public struct BRMP3File: Identifiable, Codable, Hashable {
    public static func == (lhs: BRMP3File, rhs: BRMP3File) -> Bool {
        return lhs.id == rhs.id
    }
    public var id: String?
    public var title: String?
    public var url: String?
    public var markers: Markers?
    public var duration: Double?
}
