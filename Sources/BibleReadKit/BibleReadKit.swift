import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

public struct BibleReadKit {
    
    public let jwService = JWService.shared
    public let wolService = WOLService.shared
    public let gbService = GBService.shared
    private let firEncoder = Firestore.Encoder()
    
    public init() {
        
    }

    
    public func getChapterData(bible: Bible, bookNumber: Int, chapterNumber: Int) async throws -> (WOLChapter?, GetBibleChapter?) {
        
            if let url = bible.contentApi, url.contains("jw") {
                
                if let language = bible.language, let locale = language.locale {
                    if let chapter: WOLChapter = try await wolService.getBibleChapter(locale: locale, bookNumber: bookNumber, chapterNumber: chapterNumber) {
                        return (chapter, nil)
                    }
                }
            } else {
                if let symbol = bible.symbol {
                    if let chapter: GetBibleChapter = try await gbService.getChapter(symbol: symbol, bookNumber: bookNumber, chapterNumber: chapterNumber) {
                        return (nil, chapter)
                    }
                }
            }
            return (nil, nil)
    }
    
    public func getChapterCount(bible:Bible?, bookNumber: Int) async throws -> Int? {
        if let bible, let symbol = bible.symbol, let language = bible.language, let locale = language.locale, let contentApi = bible.contentApi {
                if contentApi.contains("jw.org") {
                    if let data = try await jwService.getBible(locale: locale, symbol: symbol) {
                        if let books = data.editionData.books, let book = books["\(bookNumber)"], let chapterCount = book.chapterCount {
                            return Int(chapterCount)
                        }
                    }
                } else {
                    if let data = try await gbService.getBookChapters(symbol: symbol, bookNumber: bookNumber), let _chapters = data.chapters {
                        return _chapters.count
                    }
                }
            }
        return nil
    }
    
    public func getTotalChapters(in bible: Bible) async throws -> Int64 {
        var chaptersCount = 0
        try await (1...66).asyncForEach { bookNumber in
                if let count = try await self.getChapterCount(bible: bible, bookNumber: bookNumber) {
                    chaptersCount += count
                }
            }
        return Int64(chaptersCount)
    }

    
}
