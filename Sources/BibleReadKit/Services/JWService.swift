//
//  File.swift
//  
//
//  Created by Manuel De Freitas on 9/25/22.
//

import Foundation
import JWPubKit

public actor JWService {
    
    static public let shared = JWService()
    private let API_URL: String = "https://www.jw.org/en/library/bible/json/"
    private let PUBMEDIA_API: String = "https://b.jw-cdn.org/apis/pub-media/GETPUBMEDIALINKS"
    let decoder = JSONDecoder()
    // Get fetch file from pubmedia
    // "?booknum=0&output=json&pub=bi12&fileformat=JWPUB&alllangs=0&langwritten=E"
    @available(macOS 12.0, *)
    public func getPublicationFile(symbol: ManifestPublication.AcceptedSymbols, language: String = "E") async throws -> URL? {
        guard let url = URL(string: "\(PUBMEDIA_API)?output=json&pub=\(symbol)&fileformat=JWPUB&alllangs=0&langwritten=\(language)") else {
            print("Invalid URL")
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let pubmedia = try decoder.decode(PubMediaItem.self, from: data)

        
        let downloadService = DownloadService.shared
        guard let jwpubString = pubmedia.files?[language]?.jwpub?.first?.file?.url, let jwpubURL = URL(string: jwpubString) else { return nil }
        let fileURL = try await downloadService.download(from: jwpubURL)
        return fileURL
    }
    
    // Get bible translations
    @available(macOS 12.0, *)
    public func getBibleEditions(locale: String) async throws -> LangValue? {
        guard let url = URL(string: API_URL) else {
            print("Invalid URL")
            return nil
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(JWLibrary.self, from: data)
        return decodedResponse.langs[locale]

    }
    // get bible books data
    @available(macOS 12.0, *)
    public func getBible(locale: String, symbol: String) async throws -> JWBibleData? {
        // fetch bible editions
        let bibleEditions: LangValue? = try await getBibleEditions(locale: locale)
        if let bibleEditions {
            // filter by symbol & get url
            let edition: Edition? = bibleEditions.editions.filter { $0.symbol == symbol }.first
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
            let bibleEditions: LangValue? = try await getBibleEditions(locale: locale)
            if let bibleEditions {
                // filter by symbol & get url
                let edition: Edition? = bibleEditions.editions.filter { $0.symbol == symbol }.first
                if let edition, let contentApi = edition.contentAPI, let range = bookVerseRange(book: bookNumber, chapter: chapterNumber) {
                    guard let url = URL(string: "\(contentApi)data/\(range)") else {
                        print("Invalid URL")
                        return nil
                    }
                    // Get the data from
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let decodedResponse = try JSONDecoder().decode(JWRange.self, from: data)
                    return decodedResponse
                }
            }
        return nil
    }
    
 
}
