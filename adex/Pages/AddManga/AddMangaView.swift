//
//  AddMangaView.swift
//  adex
//
//  Created by Sena on 30/04/20.
//  Copyright © 2020 Never Mind Dev. All rights reserved.
//

import SwiftUI
import SwiftUIX
import RxSwift

struct AddMangaView: View {
    let onAdd: (Manga) -> Void
    let onCancel: () -> Void
    
    @State private var mangaIdInput: String?
    @State private var isLoading = false
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    
    private let dexService = DexService()
    private let disposeBag = DisposeBag()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Manga ID")
                TextField("Enter manga ID", text: $mangaIdInput)
                    .keyboardType(.numberPad)
                Spacer()
                    .frame(height: 24.0)
                Text("Enter the MangaDex ID of the Manga that you want to add. We'll try to streamline this process better in the future.")
                    .font(.footnote)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            .padding()
            .navigationBarTitle("Add Manga", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: onCancel, label: {
                    Text("Cancel")
                }),
                trailing: HStack {
                    if !isLoading {
                        Button(
                            action: {
                                self.isLoading = true
                                self.dexService.getManga(forId: self.mangaIdInput ?? "")
                                    .subscribe(onNext: { (manga) in
                                        self.isLoading = false
                                        self.onAdd(manga)
                                    }, onError: { (error) in
                                        self.isLoading = false
                                        debugPrint(error)
                                        
                                        switch (error as NSError).code {
                                        case 404:
                                            self.alertMessage = NSLocalizedString("Manga not found.", comment: "")
                                        case 500:
                                            self.alertMessage = NSLocalizedString("Something's wrong with MangaDex. Please try again later.", comment: "")
                                        default:
                                            self.alertMessage = NSLocalizedString("An error has occured. Please try again.", comment: "")
                                        }
                                        
                                        self.showAlert = true
                                    })
                                    .disposed(by: self.disposeBag)
                            },
                            label: {
                                Text("Add")
                            }
                        )
                    } else {
                        ActivityIndicator()
                    }
                }
            )
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Add Manga"), message: Text(alertMessage), dismissButton: .default(Text("Okay")))
            
        }
    }
}

struct AddMangaView_Previews: PreviewProvider {
    static var previews: some View {
        AddMangaView(onAdd: { (manga) in
            
        }, onCancel: {} )
        .colorScheme(.dark)
    }
}
