//
//  MangaView.swift
//  adex
//
//  Created by Sena on 29/04/20.
//  Copyright © 2020 Never Mind Dev. All rights reserved.
//

import SwiftUI

struct MangaView: View {
    let manga: Manga
    
    var body: some View {
        NavigationView {
            Text("Hello worldx")
        }
    }
}

struct MangaView_Previews: PreviewProvider {
    static var previews: some View {
        MangaView(manga: Manga.mock[0])
            .colorScheme(.dark)
    }
}
