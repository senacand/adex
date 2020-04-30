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
    
    @State var showSafari: Bool = false
    @State var safariURL: URL?
    
    var body: some View {
        List {
            InfoSection(manga: manga.manga)
                .frame(minWidth: 0, maxWidth: .infinity)
                .listRowInsets(EdgeInsets(.all, 0))
            if manga.manga.mangaDescription != "" {
                Section(header: Text("About")) {
                    Text(manga.manga.mangaDescription.htmlUnescape().split { $0.isNewline }.first ?? "")
                        .padding(.top, 8.0)
                        .padding(.bottom, 16.0)
                }
            }
            Section(header: Text("Chapters")) {
                ForEach(manga.chapter, id: \.0) { chapter  in
                    NavigationLink(destination: ReaderView(chapterId: chapter.0)) {
                        Text(chapter.1.chapterName)
                            .lineLimit(1)
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
        .sheet(isPresented: $showSafari) {
            SafariView(url: self.safariURL!)
        }
    }
}

struct MangaView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                MangaView(manga: Manga.mock[0])
            }
            .colorScheme(.dark)
            .previewDevice("iPhone X")
            
            NavigationView {
                MangaView(manga: Manga.mock[0])
            }
            .colorScheme(.light)
            .previewDevice("iPhone X")
        }
    }
}

private struct InfoSection: View {
    let manga: MangaDetail
    
    var body: some View {
        VStack {
            InfoSectionCover(coverURL: manga.coverURL)
            Spacer()
                .frame(height: 16.0)
            Text(manga.title)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            Text("By \(manga.author) - \(manga.status.title)")
                .font(.subheadline)
            Spacer()
                .frame(height: 24.0)
        }
    }
}

private struct InfoSectionCover: View {
    let coverURL: URL?
    
    var body: some View {
        ZStack(alignment: .top) {
            KFImage(coverURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 250, alignment: .center)
                .clipped()
                .blur(radius: 4.0, opaque: true)
                .opacity(0.4)
            
            KFImage(coverURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120 * 1.57)
                .clipped()
                .border(Color.systemBackground, width: 8.0)
                .padding(EdgeInsets(top: 150.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
        }
    }
}

struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }

}
