import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI
// 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
public actor BibleReadKit {
    
    public let jwService = JWService.shared
    public let wolService = WOLService.shared
    public let gbService = GBService.shared
    public let pubMediaService = PMService.shared
    private let firEncoder = Firestore.Encoder()
    
    public enum BibleSourceType {
        case secular
        case jw
    }
    
    public init() {}

    
    public func getChapterData(bible: BRBible, bookNumber: Int, chapterNumber: Int) async throws -> (WOLChapter?, GetBibleChapter?) {
        
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
    
    public func getChapterCount(bible:BRBible?, bookNumber: Int) async throws -> Int? {
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
    
    public func getTotalChapters(in bible: BRBible) async throws -> Int64 {
        var chaptersCount = 0
        try await (1...66).asyncForEach { bookNumber in
                if let count = try await self.getChapterCount(bible: bible, bookNumber: bookNumber) {
                    chaptersCount += count
                }
            }
        return Int64(chaptersCount)
    }

    public func addChapter(bible: BRBible, locale: String, book: BRBook, chapterNumber: Int) async throws -> (chapter: BRChapter, totalCount: Int?, bookCount: Int?) {
        var totalProgressCount: Int?
        var bookProgressCount: Int = 0
        var _chapter = BRChapter()
        _chapter.book = book
        _chapter.uid = UUID().uuidString
        _chapter.chapterNumber = chapterNumber
        
        
        if let bookNumber = book.bookNumber {
            
            let (wolChapter, gbChapter) = try await self.getChapterData(bible: bible, bookNumber: bookNumber, chapterNumber: chapterNumber)
    
            if let _ = wolChapter {
                // TODO: Create a layer for fecthing mp3s on a front-end
//                if let symbol = bible.symbol, let language = bible.language, let audioCode = language.audioCode, let file = try await pubMediaService.getAudioFileUrl(bookNumber: bookNumber, chapterNumber: chapterNumber, symbol: symbol, audioCode: audioCode) {
//
//                    var mep3File = BRMP3File()
//                    mep3File.title = file.title
//                    mep3File.id = UUID().uuidString
//                    mep3File.duration = file.duration
//                    mep3File.url = file.file?.url
//                    mep3File.markers = file.markers
//                    _chapter.mp3File = mep3File
//                }

                if let verses = try await wolService.getBibleVerses(locale: locale, bookNumber: bookNumber, chapterNumber: chapterNumber) {
                    _chapter.verseCount = verses.count
                    _chapter.verses = verses.map { _verse in
                        let v = BRVerse(uid: _verse.uid, chapter: _verse.chapter, verseNumber: _verse.verseNumber, content: _verse.content)
                        return v
                    }
                }
                totalProgressCount = 1
                bookProgressCount += 1
                
            }
//
            if let gbChapter, let _verses = gbChapter.verses  {

                let verses: [BRVerse] = _verses.map { element in
                    var verse = BRVerse()
                    verse.chapter = element.chapter
                    verse.uid = UUID().uuidString
                    verse.content = element.text
                    verse.verseNumber = element.verse
                    return verse
                }
                _chapter.verseCount = verses.count
                _chapter.verses = verses
                
                totalProgressCount = 1
                bookProgressCount += 1

            }
        }
        return (_chapter, totalProgressCount, bookProgressCount)
    }
    
    public func getBiblesFromLocale(language: BRLanguage) async throws -> [BRBible] {
        var bibles = [BRBible]()
        
        if let locale = language.locale, let jwBibles = try await jwService.getBibleEditions(locale: locale) {
           try await jwBibles.editions.asyncForEach { edition in
               let bibleData = try await jwService.getBible(locale: locale, symbol: edition.symbol)
               if let bibleData, let url = bibleData.editionData.url {
                   let contentApi = "https://www.jw.org\(url)json/"
                   var _bible = BRBible()
                   _bible.symbol = edition.symbol
                   _bible.name = bibleData.editionData.vernacularFullName
                   _bible.language = language
                   _bible.uid = UUID().uuidString
                   _bible.isUploaded = false
                   _bible.contentApi = contentApi
                   _bible.wolApi = language.wolApi
                   _bible.createdAt = .none
                   _bible.version = 1
                   bibles.append(_bible)
               }
            }
        }
        
        if let locale = language.locale, let gbBibles = try await gbService.getBibleTranslations(locale: locale) {
            gbBibles.forEach { translation in
                var _bible = BRBible()
                _bible.symbol = translation.abbreviation
                _bible.name = translation.translation
                _bible.language = language
                _bible.uid = UUID().uuidString
                _bible.isUploaded = false
                _bible.contentApi = translation.url
                _bible.createdAt = .none
                _bible.version = 1
                bibles.append(_bible)
            }
        }
        return bibles
    }
}
