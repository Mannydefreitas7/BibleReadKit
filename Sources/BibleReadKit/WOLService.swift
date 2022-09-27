//
//  File.swift
//  
//
//  Created by Manuel De Freitas on 9/26/22.
//

import Foundation
import SwiftSoup

public actor WOLService {
    
    static public let shared = WOLService()
    let API_URL: String = "https://wol.jw.org/wol/li"
    
    @available(macOS 12.0, *)
    public func getLanguages() async throws -> WOLLanguages? {
        do {
            guard let url = URL(string: API_URL) else {
                print("Invalid URL")
                return nil
            }
      
                let (data, _) = try await URLSession.shared.data(from: url)
                let decodedResponse = try JSONDecoder().decode(WOLLanguages.self, from: data)
                return decodedResponse
        } catch {
            throw error
        }
        return nil
    }
    
    @available(macOS 12.0, *)
    public func getBibleChapter(for locale: String, with bookNumber: Int, and chapterNumber: Int) async throws -> WOLChapter? {
        do {
            let languages = try await self.getLanguages()
            if let languages, let language = languages.items.filter({ $0.locale == locale }).first, let lib = language.libs.first {
                
                let _url = "https://wol.jw.org/wol/b/\(lib.researchConfigurationID)/\(lib.symbol)/nwt/\(bookNumber)/\(chapterNumber)"
                
                guard let url = URL(string: _url) else {
                    print("Invalid URL")
                    return nil
                }
                
                let (data, _) = try await URLSession.shared.data(from: url)
                let decodedResponse = try JSONDecoder().decode(WOLChapter.self, from: data)
                return decodedResponse
                
            }
        } catch {
           throw error
        }
        return nil
    }
    
    func parse(html: String) throws -> Array<Element>? {
        do {
            let doc: Document = try SwiftSoup.parse(html)
            let verseElements: Elements = try doc.select(".v")
            return verseElements.array()
        } catch {
            throw error
        }
        return nil
    }
    
    
    @available(macOS 12.0, *)
    public func getBibleVerses(for locale: String, with bookNumber: Int, and chapterNumber: Int) async throws -> [WOLVerse]? {
        do {
            let wolChapter: WOLChapter? = try await self.getBibleChapter(for: locale, with: bookNumber, and: chapterNumber)
            if let wolChapter {
                let html = wolChapter.content
                let elements: Array<Element>? = try self.parse(html: html)
                if let elements {
                    let verses: [WOLVerse]? = try elements.map { element in
                        var verse = WOLVerse()
                        verse.chapter = chapterNumber
                        verse.uid = UUID().uuidString
                        do {
                            let verseNumberEl = try element.select(".vp").first()
                            if let verseNumberEl {
                                let number = try verseNumberEl.text(trimAndNormaliseWhitespace: true)
                                verse.verseNumber = Int(number)
                            }
                            try element.select("a").remove()
                            let text = try element.text(trimAndNormaliseWhitespace: true)
                            verse.content = text
                                
                        } catch {
                            throw error
                        }
                        return verse
                    }
                    return verses
                }
            }
        } catch {
            throw error
        }
        return nil
    }
    
    
}
