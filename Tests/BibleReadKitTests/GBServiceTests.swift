//
//  GBServiceTests.swift
//  
//
//  Created by Manuel De Freitas on 9/28/22.
//


import XCTest
@testable import BibleReadKit

final class GBServiceTests: XCTestCase {
    private let kit = BibleReadKit()
    
    func testGetBibleTranslations() async throws {
       let data = try await kit.gbService.getBibleTranslations(locale: "en")
        XCTAssertNotNil(data)
        if let data {
            XCTAssertNotNil(data.first)
            if let first = data.first {
                XCTAssertEqual(first.lang, "en")
            }
        }
    }
    
    func testgGetBibleBooks() async throws {
        let data = try await kit.gbService.getBibleBooks(symbol: "akjv")
        XCTAssertNotNil(data)
        if let data {
            XCTAssertNotNil(data.first)
            if let first = data.first {
                XCTAssertNotNil(first.name)
                if let name = first.name {
                    XCTAssertEqual(name, "Genesis")
                }
            }
        }
    }
    
    func testGetBookChapters() async throws {
        let data = try await kit.gbService.getBookChapters(symbol: "akjv", bookNumber: 1)
        XCTAssertNotNil(data)
        if let data {
            XCTAssertNotNil(data.name)
            XCTAssertNotNil(data.chapters)
            if let name = data.name {
                XCTAssertEqual(name, "Genesis")
            }
            if let chapters = data.chapters {
                XCTAssertEqual(chapters.count, 50)
            }
        }
    }
    
    func testGetChapter() async throws {
        let data = try await kit.gbService.getChapter(symbol: "akjv", bookNumber: 1, chapterNumber: 1)
        XCTAssertNotNil(data)
        if let data {
            XCTAssertNotNil(data.name)
            XCTAssertNotNil(data.verses)
            if let name = data.name {
                XCTAssertEqual(name, "Genesis 1")
            }
            if let verses = data.verses {
                XCTAssertEqual(verses.count, 31)
            }
        }
    }
    
}

