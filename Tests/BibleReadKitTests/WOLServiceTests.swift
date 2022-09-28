//
//  WOLServiceTests.swift
//  
//
//  Created by Manuel De Freitas on 9/27/22.
//

import XCTest
@testable import BibleReadKit

final class WOLServiceTests: XCTestCase {
    private let kit = BibleReadKit()
    func testGetBibleVerses() async throws {
        if let verses = try await kit.wolService.getBibleVerses(locale: "en", bookNumber: 1, chapterNumber: 1) {
            XCTAssertGreaterThan(verses.count, 20)
        }
    }
    
    func testGetBibleChapter() async throws {
    
           let chapter = try await kit.wolService.getBibleChapter(locale: "en", bookNumber: 1, chapterNumber: 1)
            XCTAssertNotNil(chapter)
            if let chapter {
                debugPrint(chapter.title)
                XCTAssertEqual(chapter.title, "Genesis 1", "This test if the title of the wol bible chapter 1 returns 'Genesis 1'")
            }
    }
    
    func testGetLanguages() async throws {
   
            let languages = try await kit.wolService.getLanguages()
            XCTAssertNotNil(languages)
            if let languages {
                XCTAssertNotNil(languages.items.first)
                if let first = languages.items.first {
                    XCTAssertEqual(first.englishName, "Abbey")
                }
            }
    }
    
}
