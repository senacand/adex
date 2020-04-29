//
//  MangaDetail.swift
//  adex
//
//  Created by Sena on 29/04/20.
//  Copyright © 2020 Never Mind Dev. All rights reserved.
//

import Foundation

public struct MangaDetail: Codable {
    
    // Raw values
    private let coverURLRaw: String
    private let hentaiRaw: Int
    
    public let mangaDescription, title, artist: String
    public let author: String
    public let status: PubStatus
    public let genres: [Genre]
    public let lastChapter, langName, langFlag: String
    public let links: MangaLink
    
    public var coverURL: URL? {
        URL(string: "https://mangadex.org\(coverURLRaw)")
    }
    
    public var hentai: Bool {
        return hentaiRaw != 0
    }

    public enum CodingKeys: String, CodingKey {
        case coverURLRaw = "cover_url"
        case mangaDescription = "description"
        case title, artist, author, status, genres
        case lastChapter = "last_chapter"
        case langName = "lang_name"
        case langFlag = "lang_flag"
        case hentaiRaw = "hentai"
        case links
    }
}
