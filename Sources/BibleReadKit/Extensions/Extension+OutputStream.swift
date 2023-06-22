//
//  Extension+OutputStream.swift
//
//
//  Created by Manuel De Freitas on 6/20/23.
//

import Foundation

extension OutputStream {

    /// Write `Data` to `OutputStream`
    ///
    /// - parameter data:                  The `Data` to write.

    func write(_ data: Data) throws {
        try data.withUnsafeBytes { (buffer: UnsafeRawBufferPointer) throws in
            guard var pointer = buffer.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                return
            }

            var bytesRemaining = buffer.count

            while bytesRemaining > 0 {
                let bytesWritten = write(pointer, maxLength: bytesRemaining)

                bytesRemaining -= bytesWritten
                pointer += bytesWritten
            }
        }
    }
}
