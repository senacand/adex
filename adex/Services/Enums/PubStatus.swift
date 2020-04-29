//
//  PubStatus.swift
//  adex
//
//  Created by Sena on 29/04/20.
//  Copyright © 2020 Never Mind Dev. All rights reserved.
//

import Foundation

public enum PubStatus: Int, Codable {
    case ongoing = 1
    case completed = 2
    case cancelled = 3
    case hiatus = 4
    
    public var title: String {
        switch self {
        case .ongoing:
            return "Ongoing"
        case .completed:
            return "Completed"
        case .cancelled:
            return "Cancelled"
        case .hiatus:
            return "Hiatus"
        }
    }
}
