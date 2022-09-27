//
//  File.swift
//  
//
//  Created by Manuel De Freitas on 9/27/22.
//

import Foundation

public actor GBService {
    
    static public var instance = GBService()
    private let domain: String = "https://getbible.net"
    @available(macOS 12.0, *)
    public func getBibleTranslations(for locale: String) async -> [BibleTranslation]? {
        do {
            let API_URL = "\(domain)/v2/translations.json"
            guard let url = URL(string: API_URL) else {
                print("Invalid URL")
                return nil
            }
      
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode([String: BibleTranslation].self, from: data)
            let filtered = decodedResponse.filter { $0.value.lang == locale }
            return filtered.map { $0.value }
            
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    @available(macOS 12.0, *)
    public func getBibleBooks(for symbol: String) async -> [GetBibleBook]? {
        do {
            let API_URL = "\(domain)/v2/\(symbol)/books.json"
            guard let url = URL(string: API_URL) else {
                print("Invalid URL")
                return nil
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode([String: GetBibleBook].self, from: data)
            return decodedResponse.map { $0.value }

        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    @available(macOS 12.0, *)
    public func getChapters(for symbol: String, from bookNumber: Int) async -> GetBibleBook? {
        do {
            let API_URL = "\(domain)/v2/\(symbol)/\(bookNumber).json"
            guard let url = URL(string: API_URL) else {
                print("Invalid URL")
                return nil
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(GetBibleBook.self, from: data)
            return decodedResponse
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    
}
