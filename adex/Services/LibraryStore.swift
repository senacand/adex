//
//  LibraryStore.swift
//  adex
//
//  Created by Sena on 01/05/20.
//  Copyright © 2020 Never Mind Dev. All rights reserved.
//

import Foundation
import CoreData
import Combine
import RxSwift

public class LibraryStore: ObservableObject {
    private let managedContext: NSManagedObjectContext
    private let disposeBag = DisposeBag()
    private let dexService = DexService()
    
    @Published public var library: [Manga] = []
    
    init(appDelegate: AppDelegate) {
        self.managedContext = appDelegate.persistentContainer.viewContext
        
        loadLibrary()
    }
    
    public func add(manga: Manga) -> Bool {
        if library.contains(manga) {
            return false
        }
        
        guard let encodedManga = try? JSONEncoder().encode(manga) else {
            return false
        }

        let entity = NSEntityDescription.entity(
            forEntityName: "MangaData",
            in: managedContext
        )!
        let mangaData = NSManagedObject(entity: entity, insertInto: managedContext)
        
        mangaData.setValue(manga.id, forKey: "id")
        mangaData.setValue(manga.manga.title, forKey: "title")
        mangaData.setValue(manga.manga.author, forKey: "author")
        mangaData.setValue(manga.chapter.max(by: { $0.1.timestamp > $1.1.timestamp })?.1.timestamp ?? 0, forKey: "lastUpdated")
        mangaData.setValue(encodedManga, forKey: "payload")
        
        do {
            try managedContext.save()
            loadLibrary()
            
            return true
        } catch let error as NSError {
            print("Could not add. \(error), \(error.userInfo)")
            return false
        }
    }
    
    public func update(manga: Manga) {
        do {
            guard let mangaData = try getLibrary(predicate: NSPredicate(format: "id = %@", manga.id ?? "")).first,
                let encodedManga = try? JSONEncoder().encode(manga) else {
                return
            }
            
            mangaData.setValue(manga.id, forKey: "id")
            mangaData.setValue(manga.manga.title, forKey: "title")
            mangaData.setValue(manga.manga.author, forKey: "author")
            mangaData.setValue(manga.chapter.max(by: { $0.1.timestamp > $1.1.timestamp })?.1.timestamp ?? 0, forKey: "lastUpdated")
            mangaData.setValue(encodedManga, forKey: "payload")
            
            try managedContext.save()
            
            loadLibrary()
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }
    
    public func delete(manga: Manga) {
        do {
            let mangaDatas = try getLibrary(predicate: NSPredicate(format: "id = %@", manga.id ?? ""))
            
            guard let objectToDelete = mangaDatas.first else { return }
            managedContext.delete(objectToDelete)
            
            try managedContext.save()
            
            library.removeAll {
                $0 == manga
            }
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    private func loadLibrary() {
        do {
            let mangaDatas = try getLibrary()
            library = try mangaDatas.sorted(by: { (object1, object2) -> Bool in
                let lastUpdated1 = object1.value(forKey: "lastUpdated") as! Int
                let lastUpdated2 = object2.value(forKey: "lastUpdated") as! Int
                
                return lastUpdated1 > lastUpdated2
            }).map { (mangaData) -> Manga in
                try JSONDecoder().decode(Manga.self, from: mangaData.value(forKey: "payload") as! Data)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    public func updateLibrary(onCompleted: @escaping () -> Void) {
        let observables = library.map({
            self.dexService.getManga(forId: $0.id ?? "")
        })
        
        Observable.merge(observables)
            .map({ $0 as Manga? })
            .catchErrorJustReturn(nil)
            .compactMap({ $0 })
            .subscribe(onNext: { (manga) in
                self.update(manga: manga)
            }, onCompleted: {
                onCompleted()
            })
            .disposed(by: disposeBag)
    }
    
    private func getLibrary(predicate: NSPredicate? = nil) throws -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MangaData")
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
    
        do {
            return try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            throw error
        }
    }
}
