//
//  Manga.swift
//  adex
//
//  Created by Sena on 29/04/20.
//  Copyright © 2020 Never Mind Dev. All rights reserved.
//

import Foundation

public struct Manga: Codable, Identifiable {
    public var id: String {
        "\(manga.title)-\(manga.coverURL?.absoluteString ?? "")"
    }
    public let manga: MangaDetail
    private let rawChapter: [String: MangaChapter]
    public let status: String
    
    public var chapter: [(String, MangaChapter)] {
        rawChapter.filter {
            $1.langCode == "gb" // English language
        }
        .map {
            ($0.key, $0.value)
        }
        .sorted {
            $0.1.timestamp > $1.1.timestamp
        }
    }
    
    public enum CodingKeys: String, CodingKey {
        case manga, status
        case rawChapter = "chapter"
    }
    
    public static var mock: [Manga] {
        let path = Bundle.main.path(forResource: "SampleManga", ofType: "json")!
        let mockData = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        
        return try! JSONDecoder().decode([Manga].self, from: mockData)
    }
}
