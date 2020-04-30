//
//  Chapter.swift
//  adex
//
//  Created by Sena on 30/04/20.
//  Copyright © 2020 Never Mind Dev. All rights reserved.
//

import Foundation

public struct Chapter: Codable {
    public let id, timestamp: Int
    public let hash, volume, chapter, title: String
    public let langName, langCode: String
    public let mangaID, groupID, groupID2, groupID3: Int
    public let comments: Int
    public let server: String
    private let pageArray: [String]
    public let longStrip: Int
    public let status: String
    
    public var pageURLs: [URL] {
        pageArray.compactMap({
            URL(string: "\(server)\(hash)/\($0)")
        })
    }

    enum CodingKeys: String, CodingKey {
        case id, timestamp, hash, volume, chapter, title
        case langName = "lang_name"
        case langCode = "lang_code"
        case mangaID = "manga_id"
        case groupID = "group_id"
        case groupID2 = "group_id_2"
        case groupID3 = "group_id_3"
        case comments, server
        case pageArray = "page_array"
        case longStrip = "long_strip"
        case status
    }
}
