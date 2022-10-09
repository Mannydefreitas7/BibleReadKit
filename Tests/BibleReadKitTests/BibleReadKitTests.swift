import XCTest
@testable import BibleReadKit

final class BibleReadKitTests: XCTestCase {
    private let kit = BibleReadKit()
    func testDownloadBible() async throws {
        
    }
    
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

}
