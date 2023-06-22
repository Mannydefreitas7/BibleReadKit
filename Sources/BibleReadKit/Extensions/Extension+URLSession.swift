//
//  Extension+URLSession.swift
//
//
//  Created by Manuel De Freitas on 6/20/23.
//

import Foundation

public extension URLSession {
    
//    func download(from url: URL, progress parent: Progress) async throws -> (URL, URLResponse) {
//        let downloadTask = DownloadTask()
//       let observation = downloadTask.progress.observe(\.fractionCompleted) { pg, _ in
//            debugPrint(pg)
//        }
//        return try await self.download(from: url, delegate: downloadTask.self)
//    }

    
//    func download(from url: URL, progress parent: Progress) {
//        self.
//    }
//
//    func download(for request: URLRequest, delegate: URLSessionTaskDelegate? = nil, progress parent: Progress) async throws -> (URL, URLResponse) {
//        let progress = Progress()
//        parent.addChild(progress, withPendingUnitCount: 1)
//
//        let bufferSize = 65_536
//        let estimatedSize: Int64 = 1_000_000
//
//        let (asyncBytes, response) = try await bytes(for: request, delegate: delegate)
//        let expectedLength = response.expectedContentLength                             // note, if server cannot provide expectedContentLength, this will be -1
//        progress.totalUnitCount = expectedLength > 0 ? expectedLength : estimatedSize
//
//        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory())
//            .appendingPathComponent(UUID().uuidString)
//        guard let output = OutputStream(url: fileURL, append: false) else {
//            throw URLError(.cannotOpenFile)
//        }
//        output.open()
//        
//        var buffer = Data()
//        if expectedLength > 0 {
//            buffer.reserveCapacity(min(bufferSize, Int(expectedLength)))
//        } else {
//            buffer.reserveCapacity(bufferSize)
//        }
//
//        var count: Int64 = 0
//        for try await byte in asyncBytes {
//            try Task.checkCancellation()
//
//            count += 1
//            buffer.append(byte)
//
//            if buffer.count >= bufferSize {
//                try output.write(buffer)
//                buffer.removeAll(keepingCapacity: true)
//
//                if expectedLength < 0 || count > expectedLength {
//                    progress.totalUnitCount = count + estimatedSize
//                }
//                progress.completedUnitCount = count
//            }
//        }
//
//        if !buffer.isEmpty {
//            try output.write(buffer)
//        }
//
//        output.close()
//
//        progress.totalUnitCount = count
//        progress.completedUnitCount = count
//
//        return (fileURL, response)
//    }
}
