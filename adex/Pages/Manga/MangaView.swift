//
//  MangaView.swift
//  adex
//
//  Created by Sena on 29/04/20.
//  Copyright © 2020 Never Mind Dev. All rights reserved.
//

import SwiftUI
import SwiftUIX
import KingfisherSwiftUI
import HTMLEntities
import SafariServices

struct MangaView: View {
    let manga: Manga
    let libraryStore: LibraryStore
    
    @State private var readHistory: [String: Bool] = [:]
    @State private var showSafari: Bool = false
    @State private var safariURL: URL?
    
    init(manga: Manga, libraryStore: LibraryStore) {
        self.manga = manga
        self.libraryStore = libraryStore
        
        _readHistory = State(initialValue: self.libraryStore.getReadHistory(forMangaId: self.manga.id ?? ""))
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 12.0) {
                ZStack(alignment: .bottom) {
                    KFImage(manga.manga.coverURL)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 280, alignment: .center)
                        .clipped()
                        .padding(.horizontal, -20.0)
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.systemBackground, Color.systemBackground.opacity(0.0)]), startPoint: .bottom, endPoint: .top))
                        .frame(height: 50.0)
                        .padding(.horizontal, -20.0)
                }
                InfoSection(manga: manga.manga)
                GenresSection(genres: manga.manga.genres)
                    .padding(.horizontal, -20.0)
                ControlSection()
                    .padding(.bottom, 12.0)
                if manga.manga.mangaDescription != "" {
                    AboutSection(description: String(manga
                        .manga
                        .mangaDescription
                        .htmlUnescape()
                        .split { $0.isNewline }
                        .first ?? "")
                    )
                        .padding(.bottom, 8.0)
                }
                ChaptersSection(mangaId: manga.id ?? "", chapters: manga.chapter, libraryStore: libraryStore)
                Button(action: {
                    UIApplication.shared.open(URL(string: "https://mangadex.org/title/\(self.manga.id ?? "")")!)
                }) {
                    Text("Open in MangaDex")
                }
            }
            .padding(.horizontal, 20.0)
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
        .onAppear {
            self.readHistory = self.libraryStore.getReadHistory(forMangaId: self.manga.id ?? "")
        }
    }
}

struct MangaView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                MangaView(manga: Manga.mock[0], libraryStore: LibraryStore(appDelegate: UIApplication.shared.delegate as! AppDelegate))
            }
            .colorScheme(.dark)
            .previewDevice("iPhone X")
            .font(.adexBody)
            
            NavigationView {
                MangaView(manga: Manga.mock[0], libraryStore: LibraryStore(appDelegate: UIApplication.shared.delegate as! AppDelegate))
            }
            .colorScheme(.light)
            .previewDevice("iPhone X")
            .font(.adexBody)
        }
    }
}

private struct AboutSection: View {
    let description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("About")
                    .font(.adexSubtitle)
                    .fontWeight(.semibold)
                    .padding(.bottom, 12.0)
                Text(description)
                    .font(.adexBody)
                .lineSpacing(6)
            }
            .padding(16.0)
        }
        .backgroundColor(.cardBackground)
        .cornerRadius(16.0)
    }
}

private struct InfoSection: View {
    let manga: MangaDetail
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(manga.title)
                .font(.adexTitle)
                .bold()
            Text("By \(manga.author)")
                .font(.adexSubtitle)
        }
    }
}

private struct GenresSection: View {
    let genres: [Genre]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(genres, id: \.self) { genre in
                    Text(genre.title)
                        .padding(EdgeInsets(top: 8.0, leading: 16.0, bottom: 8.0, trailing: 16.0))
                        .backgroundColor(Color.cardBackground)
                        .cornerRadius(16.0)
                }
            }
            .padding(.horizontal, 20.0)
        }
    }
}

private struct ControlSection: View {
    var body: some View {
        HStack {
            Button(action: {
                
            }) {
                HStack {
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(width: 12, height: 12, alignment: .center)
                    Text("Start Reading")
                }
                .padding(.all, 12.0)
                .backgroundColor(Color.action)
                .cornerRadius(4.0)
                .foregroundColor(Color.white)
            }
            Button(action: {
                
            }) {
                HStack {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 12, height: 12, alignment: .center)
                    Text("Add to Library")
                }
                .padding(.all, 12.0)
                .cornerRadius(4.0)
                .foregroundColor(Color.label)
            }
        }
    }
}

private struct ChaptersSection: View {
    let mangaId: String
    let chapters: [(String, MangaChapter)]
    let readHistory: [String: Bool] = [:]
    let libraryStore: LibraryStore
    
    @State private var selection: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            Text("Chapters")
                .font(.adexSubtitle)
                .fontWeight(.semibold)
                .padding(.bottom, 12.0)
            ForEach(chapters, id: \.0) { chapter  in
                VStack {
                    HStack {
                        if !self.readHistory[chapter.0, default: false] {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 8.0, height: 8.0, alignment: .center)
                        }
                        NavigationLink(destination: ReaderView(chapterId: chapter.0), tag: chapter.0, selection: self.$selection) {
                            Text(chapter.1.chapterName)
                                .lineLimit(1)
                                .foregroundColor(.label)
                        }
                        .onTapGesture {
                            self.selection = chapter.0
                            self.libraryStore.addReadHistory(forMangaId: self.mangaId, chapterId: chapter.0)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    Divider()
                }
                .padding(.vertical, 8.0)
            }
        }
        .padding(.all, 16.0)
        .backgroundColor(.cardBackground)
        .cornerRadius(16.0)
    }
}
