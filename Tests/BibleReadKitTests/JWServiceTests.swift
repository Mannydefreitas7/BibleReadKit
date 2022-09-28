//
//  JWServiceTests.swift
//  
//
//  Created by Manuel De Freitas on 9/28/22.
//

import XCTest
@testable import BibleReadKit

final class JWServiceTests: XCTestCase {
    private let kit = BibleReadKit()
    func testGetBibleEditions() async throws {
        let edition = try await kit.jwService.getBibleEditions(locale: "en")
        XCTAssertNotNil(edition)
        if let edition {
            XCTAssertEqual(edition.lang.symbol, "en")
        }
    }
    
    func testGetBible() async throws {
        let data = try await kit.jwService.getBible(locale: "en", symbol: "nwt")
        XCTAssertNotNil(data)
        if let data {
            XCTAssertNotNil(data.editionData.locale)
            if let locale = data.editionData.locale {
                XCTAssertEqual(locale, "en")
            }
        }
    }
    
    func testGetRangeVerses() async throws {
        let data = try await kit.jwService.getRangeVerses(locale: "en", symbol: "nwt", bookNumber: 1, chapterNumber: 1)
        XCTAssertNotNil(data)
        if let data {
            XCTAssertNotNil(data.ranges)
            if let ranges = data.ranges {
                XCTAssertNotNil(ranges.first)
                if let first = ranges.first {
                    XCTAssertNotNil(first.value.validRange)
                    if let value = first.value.validRange {
                        XCTAssertEqual(value, "1001001-1001031")
                    }
                }
                
            }
        }
    }
}
