//
//  ReaderView.swift
//  adex
//
//  Created by Sena on 30/04/20.
//  Copyright © 2020 Never Mind Dev. All rights reserved.
//

import SwiftUI
import SwiftUIX
import RxSwift
import KingfisherSwiftUI
import Kingfisher

typealias View = SwiftUI.View // Kingfisher and SwiftUI both have "View"

struct ReaderView: View {
    private let disposeBag = DisposeBag()
    private let service = DexService()
    let chapterId: String
    
    @State var hasAppeared: Bool = false
    @State var chapterPages: [URL] = []
    @State var currentPageIndex: Int = 0
    
    var body: some View {
        PaginationView(axis: .horizontal, transitionStyle: .pageCurl, showsIndicators: false) {
            ForEach(self.chapterPages, id: \.absoluteString) { url in
                GeometryReader { geometry in
                    KFImage(url)
                        .placeholder {
                            ActivityIndicator()
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                        .clipped()
                    .backgroundColor(.black)
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            if !self.hasAppeared {
                self.fetchChapter()
                self.hasAppeared = true
            }
        }
    }
    
    private func fetchChapter() {
        service
            .getChapter(forId: self.chapterId)
            .subscribe(onNext: { (chapter) in
                self.chapterPages = chapter.pageURLs
                self.preloadImages(for: self.chapterPages)
            }, onError: { (error) in
                debugPrint(error)
            })
            .disposed(by: self.disposeBag)
    }
    
    /// Preload page images sequentially.
    private func preloadImages(for urls: [URL], index: Int = 0) {
        guard index < urls.count else { return }
        KingfisherManager.shared.retrieveImage(with: urls[index]) { (_) in
            self.preloadImages(for: urls, index: index + 1)
        }
    }
}

struct ReaderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReaderView(chapterId: "875012")
        }
    }
}
