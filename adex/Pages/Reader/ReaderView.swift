//
//  ReaderView.swift
//  adex
//
//  Created by Sena on 30/04/20.
//  Copyright © 2020 Never Mind Dev. All rights reserved.
//

import SwiftUI
import RxSwift
import KingfisherSwiftUI

struct ReaderView: View {
    private let disposeBag = DisposeBag()
    private let service = DexService()
    let chapterId: String
    
    @State var chapterPages: [URL] = []
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: true) {
                HStack {
                    ForEach(self.chapterPages, id: \.absoluteString) { url in
                        KFImage(url)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                            .clipped()
                    }
                }
            }
        }
        .onAppear(perform: self.fetchChapter)
    }
    
    private func fetchChapter() {
        service
            .getChapter(forId: self.chapterId)
            .subscribe(onNext: { (chapter) in
                self.chapterPages = chapter.pageURLs
            }, onError: { (error) in
                debugPrint(error)
            })
            .disposed(by: self.disposeBag)
    }
}

struct ReaderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReaderView(chapterId: "875012")
        }
    }
}
