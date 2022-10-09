//
//  File.swift
//  
//
//  Created by Manuel De Freitas on 10/8/22.
//

import Foundation
import RealmSwift
import FirebaseFirestore
import FirebaseFirestoreSwift


public actor FIRBibleService {

    private var firestore = Firestore.firestore()
    static public var shared = FIRBibleService()
    
    @available(macOS 12.0, *)
    public func fetchBooks(for bible: BRBible) async throws -> [BRBook]? {
        if let language = bible.language, let locale = language.locale, let uid = bible.uid {
            // Fetching books from Firestore
            let bibleBookDocuments = try await firestore.collection("languages").document(locale).collection("bibles").document(uid)
                .collection("books").getDocuments()
            let bibleBooks = try bibleBookDocuments.documents.compactMap { document in
                return try document.data(as: BRBook.self)
            }
            return bibleBooks
        }
        return nil
    }
    
    @available(macOS 12.0, *)
    public func getBookChapters(for bible: BRBible, book: BRBook) async throws -> [BRChapter]? {
        if let language = bible.language, let locale = language.locale, let bookNumber = book.bookNumber, let uid = bible.uid {
            let querySnapshot = try await firestore.collection("languages").document(locale).collection("bibles").document(uid)
                .collection("books").document("\(bookNumber)").collection("chapters").getDocuments()
            let chapters: [BRChapter] = try querySnapshot.documents.compactMap { document in
                return try document.data(as: BRChapter.self)
            }
            return chapters
        }
        return nil
    }
    
   // @available(macOS 12.0, *)
    public func download(bible: BRBible) async throws -> LocalBible {
        // Create bible object
        let localBible = LocalBible()
        localBible.name = bible.name ?? ""
        localBible.contentApi = bible.contentApi ?? ""
        localBible.symbol = bible.symbol ?? ""
        localBible.uid = bible.uid ?? ""
        
        let localLanguage = LocalLanguage()
        // Create language object
        if let language = bible.language {
           
            localLanguage.name = language.name ?? ""
            localLanguage.uid = language.uid ?? ""
            localLanguage.locale = language.locale ?? ""
            localLanguage.vernacularName = language.vernacularName ?? ""
            localLanguage.api = language.api ?? ""
            localLanguage.isRTL = language.isRTL ?? false
            localLanguage.audioCode = language.audioCode ?? ""
            localBible.language = localLanguage
        }
        
        
        
        let localBooks = List<LocalBook>()
        let books = try await self.fetchBooks(for: bible)
        if let books {
            // Create Book object
            try await books.asyncForEach { book in
                let localBook = LocalBook()
                localBook.name = book.name ?? ""
                localBook.bookNumber = book.bookNumber ?? 1
                localBook.chapterCount = book.chapterCount ?? 1
                localBook.range = book.range ?? ""
                localBook.shortName = book.shortName ?? ""
                localBook.title = book.title ?? ""
                if let bookNumber = book.bookNumber {
                    localBook.type = bookNumber > 39 ? .greek : .hebrew
                }
               
                
                let chapters = try await self.getBookChapters(for: bible, book: book)
                
                if let chapters {
                    let localChapters = List<LocalChapter>()
                    // Create Chapter Object
                    await chapters.concurrentForEach { chapter in
                        let localChapter = LocalChapter()
                        localChapter.chapterNumber = chapter.chapterNumber ?? 1
                        localChapter.verseCount = chapter.verseCount ?? 1
                        localChapter.verseRange = chapter.verseRange ?? ""
                        
                        let localVerses = List<LocalVerse>()
                        if let verses = chapter.verses {
                            await verses.asyncForEach { verse in
                                let localVerse = LocalVerse()
                                localVerse.chapterNumber = chapter.chapterNumber ?? 1
                                localVerse.verseNumber = verse.verseNumber ?? 1
                                localVerse.uid = verse.uid ?? ""
                                guard let content = verse.content else {
                                    return
                                }
                                localVerse.content = content
                                localVerses.append(localVerse)
                                
                            }
                            localChapter.verses = localVerses
                            localChapters.append(localChapter)
                        }
                        localBook.chapters = localChapters
                    }
                    localBooks.append(localBook)
                }
                
            }
            localBible.books = localBooks
        }
        return localBible
    }
}
