//
//  File.swift
//  
//
//  Created by Manuel De Freitas on 10/8/22.
//

import Foundation
import RealmSwift
import FirebaseFirestore
import FirebaseFirestoreSwift


public actor FIRBibleService {

    private var firestore = Firestore.firestore()
    static public var shared = FIRBibleService()
    
}
