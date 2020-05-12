//
//  LibraryView.swift
//  adex
//
//  Created by Sena on 29/04/20.
//  Copyright © 2020 Never Mind Dev. All rights reserved.
//

import SwiftUI
import SwiftUIX
import KingfisherSwiftUI

struct LibraryView: View {
    @ObservedObject var libraryStore: LibraryStore
    
    @State private var hasAppeared: Bool = false
    @State private var showAddManga: Bool = false
    @State private var isLoading: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            List {
                ForEach(libraryStore.library) { manga in
                    NavigationLink(destination: MangaView(manga: manga, libraryStore: self.libraryStore)) {
                        MangaRow(manga: manga.manga)
                    }
                }
                .onDelete { (indexSet) in
                    for index in indexSet {
                        self.libraryStore.delete(manga: self.libraryStore.library[index])
                    }
                }
            }
            .navigationBarTitle(Text("My Library"))
            .navigationBarItems(
                leading: VStack {
                    if !self.isLoading {
                        Button(action: updateLibrary, label: {
                            Text("Refresh")
                        })
                    } else {
                        ActivityIndicator()
                    }
                },
                trailing: Button(action: { self.showAddManga = true }, label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add")
                    }
                })
            )
            .onAppear(perform: {
                if !self.hasAppeared {
                    self.updateLibrary()
                    self.hasAppeared = true
                }
            })
            .sheet(isPresented: $showAddManga) {
                AddMangaView(onAdd: { (manga) in
                    let _ = self.libraryStore.add(manga: manga)
                    self.showAddManga = false
                }, onCancel: { self.showAddManga = false })
                .colorScheme(self.colorScheme)
            }
        }
    }
    
    private func updateLibrary() {
        isLoading = true
        libraryStore.updateLibrary {
            self.isLoading = false
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        let store = LibraryStore(appDelegate: UIApplication.shared.delegate as! AppDelegate)
        return Group {
            LibraryView(libraryStore: store)
                .colorScheme(ColorScheme.dark)
                .previewDevice("iPhone X")
            LibraryView(libraryStore: store)
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
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60*1.57)
                .clipped()
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
