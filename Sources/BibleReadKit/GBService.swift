//
//  File.swift
//  
//
//  Created by Manuel De Freitas on 9/27/22.
//

import Foundation

public actor GBService {
    
    static public var shared = GBService()
    private let domain: String = "https://getbible.net"
    @available(macOS 12.0, *)
    public func getBibleTranslations(locale: String) async throws -> [BibleTranslation]? {
        let API_URL = "\(domain)/v2/translations.json"
        guard let url = URL(string: API_URL) else {
            print("Invalid URL")
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode([String: BibleTranslation].self, from: data)
        let filtered = decodedResponse.filter { $0.value.lang == locale }
        return filtered.map { $0.value }
    }
    
    @available(macOS 12.0, *)
    public func getBibleBooks(symbol: String) async throws -> [GetBibleBook]? {
        
        let API_URL = "\(domain)/v2/\(symbol)/books.json"
        guard let url = URL(string: API_URL) else {
            print("Invalid URL")
            return nil
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode([String: GetBibleBook].self, from: data)
        return decodedResponse.map { $0.value }.sorted { ($0.nr ?? 1) < ($1.nr ?? 0) }
    }
    
    @available(macOS 12.0, *)
    public func getBookChapters(symbol: String, bookNumber: Int) async throws -> GetBibleBook? {
        
        let API_URL = "\(domain)/v2/\(symbol)/\(bookNumber).json"
        guard let url = URL(string: API_URL) else {
            print("Invalid URL")
            return nil
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(GetBibleBook.self, from: data)
        return decodedResponse
    }
    
    
    @available(macOS 12.0, *)
    public func getChapter(symbol: String, bookNumber: Int, chapterNumber: Int) async throws -> GetBibleChapter? {
        
        let API_URL = "\(domain)/v2/\(symbol)/\(bookNumber)/\(chapterNumber).json"
        guard let url = URL(string: API_URL) else {
            print("Invalid URL")
            return nil
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(GetBibleChapter.self, from: data)
        return decodedResponse
    }
    
    
}
