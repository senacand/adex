//
//  Chapter.swift
//  adex
//
//  Created by Sena on 29/04/20.
//  Copyright © 2020 Never Mind Dev. All rights reserved.
//

import Foundation

public struct MangaChapter: Codable {
    public let volume, chapter, title: String
    public let langCode: String
    public let groupID: Int?
    public let groupName: String?
    public let groupID2: Int?
    public let groupName2: String?
    public let groupID3: Int?
    public let groupName3: String?
    public let timestamp: Int
    
    public var chapterName: String {
        [
            (volume != "") ? "Vol. \(volume)" : nil,
            (chapter != "") ? "Chapter \(chapter)" : nil,
            (title != "") ? ": \(title)" : nil
        ]
        .compactMap({ $0 })
        .joined(separator: " ")
    }

    public enum CodingKeys: String, CodingKey {
        case volume, chapter, title
        case langCode = "lang_code"
        case groupID = "group_id"
        case groupName = "group_name"
        case groupID2 = "group_id_2"
        case groupName2 = "group_name_2"
        case groupID3 = "group_id_3"
        case groupName3 = "group_name_3"
        case timestamp
    }
}
