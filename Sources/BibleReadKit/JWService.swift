//
//  File.swift
//  
//
//  Created by Manuel De Freitas on 9/25/22.
//

import Foundation

public actor JWService {
    
    static public let shared = JWService()
    private let API_URL: String = "https://www.jw.org/en/library/bible/json/"
    
    // Get bible translations
    @available(macOS 12.0, *)
    public func getBibleEditions(locale: String) async throws -> LangValue? {
        do {
            guard let url = URL(string: API_URL) else {
                print("Invalid URL")
                return nil
            }
      
                let (data, _) = try await URLSession.shared.data(from: url)
                let decodedResponse = try JSONDecoder().decode(JWLibrary.self, from: data)
                return decodedResponse.langs[locale]
            
        } catch {
            throw error
        }
    }
    // get bible books data
    @available(macOS 12.0, *)
    public func getBible(locale: String, symbol: String) async throws -> JWBibleData? {
        do {
            
                // fetch bible editions
                let bibleEditions: LangValue? = try await getBibleEditions(locale: locale)
                if let bibleEditions {
                    // filter by symbol & get url
                    let edition: Edition? = bibleEditions.editions.filter { $0.symbol.rawValue == symbol }.first
                    if let edition, let contentApi = edition.contentAPI {
                
                        guard let url = URL(string: contentApi) else {
                            print("Invalid URL")
                            return nil
                        }
                        // Get the data from
                        let (data, _) = try await URLSession.shared.data(from: url)
                        let decodedResponse = try JSONDecoder().decode(JWBibleData.self, from: data)
                        return decodedResponse
                    }
                }
            
        } catch {
            throw error
        }
        return nil
    }
    
    func bookVerseRange(book: Int, chapter: Int) -> String? {
            if chapter <= 9 {
                return "\(book)001001-\(book)00\(chapter)999"
            }
            if chapter > 9 {
                return   "\(book)001001-\(book)0\(chapter)999"
            }
            if chapter > 99 {
                return "\(book)001001-\(book)\(chapter)999"
            }
        return nil
    }
    
    func verseRange(_ verseCount: Int) -> String? {
        if verseCount <= 9 {
            return "00\(verseCount)"
        }
        if verseCount > 9 {
            return "0\(verseCount)"
        }
        if verseCount > 99 {
            return "\(verseCount)"
        }
        return nil
    }
    
    
    
    @available(macOS 12.0, *)
    public func getRangeVerses(locale: String, symbol: String, bookNumber: Int, chapterNumber: Int) async throws -> JWRange? {
        do {
            let bibleEditions: LangValue? = try await getBibleEditions(locale: locale)
            if let bibleEditions {
                // filter by symbol & get url
                let edition: Edition? = bibleEditions.editions.filter { $0.symbol.rawValue == symbol }.first
                if let edition, let contentApi = edition.contentAPI, let range = bookVerseRange(book: bookNumber, chapter: chapterNumber) {
            
                    guard let url = URL(string: "\(contentApi)/data/\(range)") else {
                        print("Invalid URL")
                        return nil
                    }
                    // Get the data from
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let decodedResponse = try JSONDecoder().decode(JWRange.self, from: data)
                    return decodedResponse
                }
            }
        } catch {
            throw error
        }
        return nil
    }
    
 
}
