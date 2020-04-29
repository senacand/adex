//
//  LibraryView.swift
//  adex
//
//  Created by Sena on 29/04/20.
//  Copyright © 2020 Never Mind Dev. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct LibraryView: View {
    let library = Manga.mock
    
    var body: some View {
        NavigationView {
            List(library) { manga in
                NavigationLink(destination: MangaView(manga: manga)) {
                    MangaRow(manga: manga.manga)
                }
            }
            .navigationBarTitle(Text("My Library"))
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LibraryView()
                .colorScheme(ColorScheme.dark)
                .previewDevice("iPhone X")
            LibraryView()
                .colorScheme(ColorScheme.light)
                .previewDevice("iPhone X")
        }
    }
}

struct MangaRow: View {
    let manga: MangaDetail
    
    var body: some View {
        HStack {
            KFImage(manga.coverURL)
                .resizable()
                .frame(width: 60, height: 60*1.57)
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text(manga.title)
                        .bold()
                        .lineLimit(2)
                    if manga.hentai {
                        Text("H")
                            .foregroundColor(Color.white)
                            .bold()
                            .font(.caption)
                            .padding(EdgeInsets(top: 2.0, leading: 4.0, bottom: 2.0, trailing: 4.0))
                            .background(
                                RoundedRectangle(cornerRadius: 4.0)
                                    .fill(Color.red)
                        )
                    }
                }
                Text(manga.author)
                    .font(.subheadline)
                Spacer()
                    .frame(height: 8.0)
                Text(
                    manga.genres.map {
                        $0.title
                    }.joined(separator: ", ")
                )
                    .font(.caption)
            }
        }
    }
}
