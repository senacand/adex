//
//  DexService.swift
//  adex
//
//  Created by Sena on 30/04/20.
//  Copyright © 2020 Never Mind Dev. All rights reserved.
//

import Foundation
import Moya
import RxMoya
import RxSwift

public class DexService {
    private let provider = MoyaProvider<DexProvider>(plugins: [NetworkLoggerPlugin()])
    
    public func getManga(forId id: String) -> Observable<Manga> {
        provider.rx.request(.manga(id: id))
            .asObservable()
            .map { (response) -> Manga in
                try JSONDecoder().decode(Manga.self, from: response.data)
            }
            .map { (manga) -> Manga in
                var manga = manga
                manga.id = id
                
                return manga
            }
    }
    
    public func getChapter(forId id: String) -> Observable<Chapter> {
        provider.rx.request(.chapter(id: id))
            .asObservable()
            .map { (response) -> Chapter in
                try JSONDecoder().decode(Chapter.self, from: response.data)
            }
    }
}
