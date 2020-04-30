//
//  AddMangaView.swift
//  adex
//
//  Created by Sena on 30/04/20.
//  Copyright © 2020 Never Mind Dev. All rights reserved.
//

import SwiftUI
import RxSwift

struct AddMangaView: View {
    let onAdd: (Manga) -> Void
    
    @State private var mangaIdInput: String?
    private let disposeBag = DisposeBag()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Manga ID")
                TextField("Enter manga ID", text: $mangaIdInput)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            .padding()
            .navigationBarTitle("Add Manga", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(
                    action: {
                        let service = DexService()
                        service.getManga(forId: self.mangaIdInput ?? "")
                            .subscribe(onNext: { (manga) in
                                self.onAdd(manga)
                            }, onError: { (error) in
                                debugPrint(error)
                            })
                            .disposed(by: self.disposeBag)
                    },
                    label: {
                        Text("Add")
                    }
                )
            )
        }
    }
}

struct AddMangaView_Previews: PreviewProvider {
    static var previews: some View {
        AddMangaView(onAdd: { (manga) in
            
        })
        .colorScheme(.dark)
    }
}
