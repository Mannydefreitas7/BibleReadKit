@testable import BibleReadKit
import JWPubKit
import XCTest

final class BibleReadKitTests: XCTestCase {
    private let kit = BibleReadKit()

    func testGetChapterDataForJW() async throws {
        var bible = BRBible()
        var language = BRLanguage()
        language.locale = "en"
        bible.language = language
        bible.contentApi = "www.jw.org"
        
        let (wolChapter, gbChapter) = try await kit.getChapterData(bible: bible, bookNumber: 1, chapterNumber: 1)
        XCTAssertNotNil(wolChapter)
        XCTAssertNil(gbChapter)
        if let wolChapter {
            XCTAssertEqual(wolChapter.title, "Genesis 1")
        }
    }
    
    func testGetChapterDataForGB() async throws {
        var bible = BRBible()
        bible.symbol = "akjv"
        bible.language?.locale = "en"
        bible.contentApi = "www.getBible.org"
        
        let (wolChapter, gbChapter) = try await kit.getChapterData(bible: bible, bookNumber: 1, chapterNumber: 1)
        XCTAssertNotNil(gbChapter)
        XCTAssertNil(wolChapter)
        if let gbChapter {
            XCTAssertEqual(gbChapter.name, "Genesis 1")
        }
    }
    
    func testGetChapterCountForJW() async throws {
        var bible = BRBible()
        var language = BRLanguage()
        language.locale = "en"
        bible.language = language
        bible.symbol = "nwt"
        bible.contentApi = "www.jw.org"
        let count = try await kit.getChapterCount(bible: bible, bookNumber: 1)
        XCTAssertNotNil(count)
        if let count {
            XCTAssertEqual(count, 50)
        }
    }

    func testGetChapterCountForGB() async throws {
        var bible = BRBible()
        bible.symbol = "akjv"
        bible.contentApi = "www.getBible.org"
        var language = BRLanguage()
        language.locale = "en"
        bible.language = language
        let count = try await kit.getChapterCount(bible: bible, bookNumber: 2)
        XCTAssertNotNil(count)
        if let count {
            XCTAssertEqual(count, 40)
        }
    }
    
    func testGetTotalChapters() async throws {
        var bible = BRBible()
        bible.symbol = "akjv"
        bible.contentApi = "www.getBible.org"
        var language = BRLanguage()
        language.locale = "en"
        bible.language = language
        let count = try await kit.getTotalChapters(in: bible)
        XCTAssertGreaterThan(count, 1000)
    }
    
    func testGetAudioFileUrls() async throws {
        let files = try await kit.pubMediaService.getAudioFileUrls()
        XCTAssertNotNil(files)
        if let files {
            XCTAssertGreaterThan(files.count, 48)
            XCTAssertNotNil(files.first)
            if let file = files.first, let chapterName = file.title {
                XCTAssertEqual(chapterName, "Chapter 1")
            }
        }
    }
    
    func testGetAudioFileUrl() async throws {
        let file = try await kit.pubMediaService.getAudioFileUrl(bookNumber: 1, chapterNumber: 1, symbol: "nwt", audioCode: "E")
        XCTAssertNotNil(file)
        if let file {
            if let chapterName = file.title {
                XCTAssertEqual(chapterName, "Chapter 1")
            }
        }
    }
    
    func testAddChapter() async throws {
        let bible = BRBible().mockBRBible()
        let book = BRBook().mockBRBook()
        let (chapter, totalCount, bookCount) = try await kit.addChapter(bible: bible, locale: "en", book: book, chapterNumber: 1)
        XCTAssertNotNil(totalCount)
        XCTAssertNotNil(bookCount)
        XCTAssertNotNil(chapter.verses)
        if let verses = chapter.verses {
            XCTAssertGreaterThan(verses.count, 30)
        }
        //  XCTAssertNotNil(chapter.mp3File)
        if let file = chapter.mp3File {
            XCTAssertNotNil(file.title)
            if let chapterName = file.title {
                XCTAssertEqual(chapterName, "Chapter 1")
            }
        }
    }
    
    func testDownloadAndReadFile() async throws {
        let file = try await kit.getPublicationFile(symbol: .nwt)
       
        XCTAssertNotNil(file)
        if let file {
            var progress: Progress = .init()
            let object = try await kit.parseJWPUB(from: file, progress: progress)
            if let bible = object as? JWPBible {
                XCTAssertEqual(bible.title, "New World Translation of the Holy Scriptures")
                XCTAssertNotNil(bible.books.first?.chapters.first?.content)
            }
        }
    }
    
    func testGetBiblesFromLanguage() async throws {
        let language = BRLanguage().mockLanguage()
        let bibles = try await kit.getBiblesFromLocale(language: language)
        XCTAssertGreaterThan(bibles.count, 0)
    }
}
