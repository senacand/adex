//
//  DexProvider.swift
//  adex
//
//  Created by Sena on 29/04/20.
//  Copyright © 2020 Never Mind Dev. All rights reserved.
//

import Foundation
import Moya

public enum DexProvider {
    case manga(id: String)
    case chapter(id: String)
}

extension DexProvider: TargetType {
    public var baseURL: URL {
        URL(string: "https://mangadex.org/api/")!
    }
    
    public var path: String {
        switch self {
        case .manga(let id):
            return "manga/\(id)"
        case .chapter(let id):
            return "chapter/\(id)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .manga, .chapter:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .manga, .chapter:
            return Task.requestPlain
        }
    }
    
    public var headers: [String : String]? {
        nil
    }
}
