//
//  Manga.swift
//  adex
//
//  Created by Sena on 29/04/20.
//  Copyright © 2020 Never Mind Dev. All rights reserved.
//

import Foundation

public struct Manga: Codable, Identifiable, Equatable {
    public var id: String?
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
            Double($0.1.chapter) ?? 0 > Double($1.1.chapter) ?? 0
        }
    }
    
    public enum CodingKeys: String, CodingKey {
        case id, manga, status
        case rawChapter = "chapter"
    }
    
    public static var mock: [Manga] {
        let path = Bundle.main.path(forResource: "SampleManga", ofType: "json")!
        let mockData = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        
        return try! JSONDecoder().decode([Manga].self, from: mockData)
            .map { (manga) -> Manga in
                var mangaCopy = manga
                mangaCopy.id = manga.manga.title
                
                return mangaCopy
            }
    }
    
    public static func == (lhs: Manga, rhs: Manga) -> Bool {
        lhs.id == rhs.id
    }
}
