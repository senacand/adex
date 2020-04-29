//
//  Genre.swift
//  adex
//
//  Created by Sena on 29/04/20.
//  Copyright © 2020 Never Mind Dev. All rights reserved.
//

import Foundation

public enum Genre: Int {
    case yonKoma = 1
    case action = 2
    case adventure = 3
    case awardWinning = 4
    case comedy = 5
    case cooking = 6
    case doujinshi = 7
    case drama = 8
    case ecchi = 9
    case fantasy = 10
    case gyaru = 11
    case harem = 12
    case historical = 13
    case horror = 14
    case josei = 15
    case martialArts = 16
    case mecha = 17
    case medical = 18
    case music = 19
    case mystery = 20
    case oneshot = 21
    case psychological = 22
    case romance = 23
    case schoolLife = 24
    case sciFi = 25
    case seinen = 26
    case shoujo = 27
    case shoujoAi = 28
    case shounen = 29
    case shounenAi = 30
    case sliceOfLife = 31
    case smut = 32
    case sports = 33
    case supernatural = 34
    case tragedy = 35
    case longStrip = 36
    case yaoi = 37
    case yuri = 38
    case noChapters = 39
    case videoGames = 40
    case isekai = 41
    case adaptation = 42
    case anthology = 43
    case webComic = 44
    case fullColor = 45
    case userCreated = 46
    case officialColored = 47
    case fanColored = 48
    case gore = 49
    case sexualViolence = 50
    case crime = 51
    case magicalGirls = 52
    case philosophical = 53
    case superhero = 54
    case thriller = 55
    case wuxia = 56
    case aliens = 57
    case animals = 58
    case crossdressing = 59
    case demons = 60
    case delinquents = 61
    case genderswap = 62
    case ghosts = 63
    case monsterGirls = 64
    case loli = 65
    case magic = 66
    case military = 67
    case monsters = 68
    case ninja = 69
    case officeWorkers = 70
    case police = 71
    case postApocalyptic = 72
    case reincarnation = 73
    case reverseHarem = 74
    case samurai = 75
    case shota = 76
    case survival = 77
    case timeTravel = 78
    case vampires = 79
    case traditionalGames = 80
    case virtualReality = 81
    case zombies = 82
    case incest = 83
    
    public var name: String {
        switch self {
            case .yonKoma:
                return "4-Koma"
            case .action:
                return "Action"
            case .adventure:
                return "Adventure"
            case .awardWinning:
                return "Award Winning"
            case .comedy:
                return "Comedy"
            case .cooking:
                return "Cooking"
            case .doujinshi:
                return "Doujinshi"
            case .drama:
                return "Drama"
            case .ecchi:
                return "Ecchi"
            case .fantasy:
                return "Fantasy"
            case .gyaru:
                return "Gyaru"
            case .harem:
                return "Harem"
            case .historical:
                return "Historical"
            case .horror:
                return "Horror"
            case .josei:
                return "Josei"
            case .martialArts:
                return "Martial Arts"
            case .mecha:
                return "Mecha"
            case .medical:
                return "Medical"
            case .music:
                return "Music"
            case .mystery:
                return "Mystery"
            case .oneshot:
                return "Oneshot"
            case .psychological:
                return "Psychological"
            case .romance:
                return "Romance"
            case .schoolLife:
                return "School Life"
            case .sciFi:
                return "Sci-Fi"
            case .seinen:
                return "Seinen"
            case .shoujo:
                return "Shoujo"
            case .shoujoAi:
                return "Shoujo Ai"
            case .shounen:
                return "Shounen"
            case .shounenAi:
                return "Shounen Ai"
            case .sliceOfLife:
                return "Slice of Life"
            case .smut:
                return "Smut"
            case .sports:
                return "Sports"
            case .supernatural:
                return "Supernatural"
            case .tragedy:
                return "Tragedy"
            case .longStrip:
                return "Long Strip"
            case .yaoi:
                return "Yaoi"
            case .yuri:
                return "Yuri"
            case .noChapters:
                return "[no chapters]"
            case .videoGames:
                return "Video Games"
            case .isekai:
                return "Isekai"
            case .adaptation:
                return "Adaptation"
            case .anthology:
                return "Anthology"
            case .webComic:
                return "Web Comic"
            case .fullColor:
                return "Full Color"
            case .userCreated:
                return "User Created"
            case .officialColored:
                return "Official Colored"
            case .fanColored:
                return "Fan Colored"
            case .gore:
                return "Gore"
            case .sexualViolence:
                return "Sexual Violence"
            case .crime:
                return "Crime"
            case .magicalGirls:
                return "Magical Girls"
            case .philosophical:
                return "Philosophical"
            case .superhero:
                return "Superhero"
            case .thriller:
                return "Thriller"
            case .wuxia:
                return "Wuxia"
            case .aliens:
                return "Aliens"
            case .animals:
                return "Animals"
            case .crossdressing:
                return "Crossdressing"
            case .demons:
                return "Demons"
            case .delinquents:
                return "Delinquents"
            case .genderswap:
                return "Genderswap"
            case .ghosts:
                return "Ghosts"
            case .monsterGirls:
                return "Monster Girls"
            case .loli:
                return "Loli"
            case .magic:
                return "Magic"
            case .military:
                return "Military"
            case .monsters:
                return "Monsters"
            case .ninja:
                return "Ninja"
            case .officeWorkers:
                return "Office Workers"
            case .police:
                return "Police"
            case .postApocalyptic:
                return "Post-Apocalyptic"
            case .reincarnation:
                return "Reincarnation"
            case .reverseHarem:
                return "Reverse Harem"
            case .samurai:
                return "Samurai"
            case .shota:
                return "Shota"
            case .survival:
                return "Survival"
            case .timeTravel:
                return "Time Travel"
            case .vampires:
                return "Vampires"
            case .traditionalGames:
                return "Traditional Games"
            case .virtualReality:
                return "Virtual Reality"
            case .zombies:
                return "Zombies"
            case .incest:
                return "Incest"
        }
    }
}
