//
//  File.swift
//  
//
//  Created by Manuel De Freitas on 9/25/22.
//

import Foundation

public class JWService {
    
    static public let instance = JWService()
    private let API_URL: String = "https://www.jw.org/en/library/bible/json/"
    
    // Get bible translations
    @available(macOS 12.0, *)
    public func getBibleEditions(for locale: String) async -> LangValue? {
        do {
            guard let url = URL(string: API_URL) else {
                print("Invalid URL")
                return nil
            }
      
                let (data, _) = try await URLSession.shared.data(from: url)
                let decodedResponse = try JSONDecoder().decode(JWLibrary.self, from: data)
                return decodedResponse.langs[locale]
            
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    // get bible books data
    @available(macOS 12.0, *)
    public func getBible(for locale: String, with symbol: String) async -> JWBibleData? {
        do {
            
                // fetch bible editions
                let bibleEditions: LangValue? = await getBibleEditions(for: locale)
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
            print(error.localizedDescription)
        }
        return nil
    }
    
    @available(macOS 12.0, *)
    public func getRangeVerses(for locale: String, with symbol: String, from range: String) async -> JWRange? {
        do {
            let bibleEditions: LangValue? = await getBibleEditions(for: locale)
            if let bibleEditions {
                // filter by symbol & get url
                let edition: Edition? = bibleEditions.editions.filter { $0.symbol.rawValue == symbol }.first
                if let edition, let contentApi = edition.contentAPI {
            
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
            print(error.localizedDescription)
        }
        return nil
    }
    
 
}
