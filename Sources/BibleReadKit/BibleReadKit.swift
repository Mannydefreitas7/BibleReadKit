import FirebaseFirestore
import FirebaseFirestoreSwift

public struct BibleReadKit {
    
    public let jwService = JWService.shared
    public let wolService = WOLService.shared
    public let gbService = GBService.shared
    private let firEncoder = Firestore.Encoder()
    
    public init() {
        
    }

    
    func getChapterData(bible: Bible, bookNumber: Int, chapterNumber: Int) async throws -> (WOLChapter?, GetBibleChapter?) {
        
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
    
    func getChapterCount(bible:Bible?, bookNumber: Int) async throws -> Int? {
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
    
    func getTotalChapters(in bible: Bible) async throws -> Int64 {
        var chaptersCount = 0
        try await (1...66).asyncForEach { bookNumber in
                if let count = try await self.getChapterCount(bible: bible, bookNumber: bookNumber) {
                    chaptersCount += count
                }
            }
        return Int64(chaptersCount)
    }
    
    public func downloadBible(firestore: Firestore, bible: Bible?, books: [Book]) async throws -> (progress: Progress, isLoading: Bool, currentBookId: String?) {
        var isLoading: Bool = false
        var currentBookId: String?
        let progress: Progress = Progress()
        
        
        if let bible,
        let uid = bible.uid,
        let language = bible.language,
        let locale = language.locale {
            
            isLoading = true
            progress.totalUnitCount = try await getTotalChapters(in: bible)
            
            await books.asyncForEach({ book in
                
                do {
                    
                    if let bookNumber = book.bookNumber,
                    let bookId = book.uid {
                        
                        let bookPath = "languages/\(locale)/bibles/\(uid)/books/\(bookNumber)"
                        currentBookId = bookId
                        let query = firestore.document(bookPath)
                        let chapterCount = try await self.getChapterCount(bible: bible, bookNumber: bookNumber)
                        var _book: Book = book
                        _book.chapterCount = chapterCount
                        let data = try firEncoder.encode(_book)
                        
                        try await query.setData(data)
                        
                        if let chapterCount {
                            
                            let chapters: [Chapter] = try await (1...chapterCount).asyncMap { c in
                                
                                var _chapter = Chapter(verses: [])
                                
                                
                                _chapter.book = book
                                _chapter.uid = UUID().uuidString
                                _chapter.chapterNumber = c
                                
                                if let bookNumber = book.bookNumber {
                                    let (wolChapter, gbChapter) = try await self.getChapterData(bible: bible, bookNumber: bookNumber, chapterNumber: c)
                                    
                                    if let _ = wolChapter {

                                        if let verses = try await wolService.getBibleVerses(locale: locale, bookNumber: bookNumber, chapterNumber: c) {
                                            _chapter.verseCount = verses.count
                                            _chapter.verses = verses.map { _verse in
                                                let v = Verse(uid: _verse.uid, chapter: _verse.chapter, verseNumber: _verse.verseNumber, content: _verse.content)
                                                return v
                                            }
                                        }
                                        progress.completedUnitCount += 1
                                    }
    //
                                    if let gbChapter, let _verses = gbChapter.verses  {

                                        let verses: [Verse] = _verses.map { element in
                                            var verse = Verse()
                                            verse.chapter = element.chapter
                                            verse.uid = UUID().uuidString
                                            verse.content = element.text
                                            verse.verseNumber = element.verse
                                            return verse
                                        }
                                        _chapter.verseCount = verses.count
                                        _chapter.verses = verses
                                        
                                        progress.completedUnitCount += 1
                                    }
                                }
                                
                                return _chapter
                                
                            }
                            
                            await chapters.asyncForEach { chapter in
                                do {
                                    let _data = try firEncoder.encode(chapter)
                                    if let chapterNumber = chapter.chapterNumber {
                                        try await query.collection("chapters").document("\(chapterNumber)").setData(_data)
                                    }
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    }
                    
                } catch {
                    print(error.localizedDescription)
                    isLoading = false
                }
            })
            currentBookId = ""
            isLoading = false
        }
        return (progress, isLoading, currentBookId)
    }
    
    
}
