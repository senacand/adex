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
    public let chapter: [String: MangaChapter]
    public let status: String
    
    public static var mock: [Manga] {
        let path = Bundle.main.path(forResource: "SampleManga", ofType: "json")!
        let mockData = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        
        return try! JSONDecoder().decode([Manga].self, from: mockData)
    }
}
