//
//  MangaStore.swift
//  adex
//
//  Created by Sena on 01/05/20.
//  Copyright © 2020 Never Mind Dev. All rights reserved.
//

import Foundation

public class MangaStore {
    private struct MangaEntity {
        let title: String
        let author: String
        let payload: Data
    }
    
    public private(set) var library: [Manga] = []
    
    public func add(manga: Manga) {
        
    }
}
