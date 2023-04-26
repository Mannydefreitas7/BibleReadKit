//
//  PMService.swift
//  
//
//  Created by Manuel De Freitas on 10/9/22.
//

import Foundation


public actor PMService {
    
    static public var shared = PMService()
    private let domain: String = "https://b.jw-cdn.org/apis/pub-media/GETPUBMEDIALINKS"
    
    @available(macOS 12.0, *)
    public func getAudioFileUrls(bookNumber: Int = 1, symbol: String = "nwt", audioCode: String = "E") async throws -> [PMMp3]? {
        let API_URL = "\(domain)?booknum=\(bookNumber)&output=json&pub=\(symbol)&fileformat=MP3&alllangs=0&langwritten=\(audioCode)"
        guard let url = URL(string: API_URL) else {
            print("Invalid URL")
            return nil
        }
        let (data, _) = try await URLSession.shared.data(from: url)
       
        let decodedResponse = try JSONDecoder().decode(PubMediaItem.self, from: data)
        if let files = decodedResponse.files, let langKeyFiles = files[audioCode], let mp3s = langKeyFiles.mp3 {
            
            var _mp3s = mp3s
            //_mp3s.removeFirst()
            return _mp3s
        }
        return nil
    }
    
    @available(macOS 12.0, *)
    public func getAudioFileUrl(bookNumber: Int = 1, chapterNumber: Int = 1, symbol: String = "nwt", audioCode: String = "E") async throws -> PMMp3? {
        let API_URL = "\(domain)?booknum=\(bookNumber)&output=json&pub=\(symbol)&fileformat=MP3&alllangs=0&langwritten=\(audioCode)&track=\(chapterNumber)"
        guard let url = URL(string: API_URL) else {
            print("Invalid URL")
            return nil
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(PubMediaItem.self, from: data)
        if let files = decodedResponse.files, let langKeyFiles = files[audioCode], let mp3s = langKeyFiles.mp3 {
            return mp3s.first
        }
        return nil
    }
}
