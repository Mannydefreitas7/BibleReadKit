//
//  DownloadService.swift
//
//
//  Created by Manuel De Freitas on 6/20/23.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

public extension UTType {
     static var jwpub: UTType {
        // Look up the type from the file extension
        UTType.types(tag: "jwpub", tagClass: .filenameExtension, conformingTo: nil).first!
    }
}

extension String: Error { }

public class DownloadService: NSObject, URLSessionDownloadDelegate {
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print(location)
    }
    
    
    static let shared = DownloadService()
    
    public func download(from url: URL) async throws -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            throw "Could not get document directory"
        }
        
        let (downloadURL, response) = try await URLSession.shared.download(from: url)
        guard let fileName = response.suggestedFilename else { throw "Could not get filename" }
        let folderURL = documentsDirectory.appending(path: UUID().uuidString)
        try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
        let temporaryURL = folderURL.appendingPathComponent(fileName, conformingTo: .jwpub)
        debugPrint(temporaryURL.absoluteString)
        if FileManager.default.fileExists(atPath: temporaryURL.absoluteString) {
            debugPrint("FILE EXISTS: \(temporaryURL.absoluteString)")
            try FileManager.default.removeItem(at: temporaryURL)
        }
       
        try FileManager.default.moveItem(at: downloadURL, to: temporaryURL)
        return temporaryURL
    }

    
}


