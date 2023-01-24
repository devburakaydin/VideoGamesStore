//
//  CoreDataManager.swift
//  VideoGamesStore
//
//  Created by Burak on 19.01.2023.
//

import UIKit
import CoreData


class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init(){}
    
    
    func saveVideoGameToFavorites(model: VideoGame, completion: @escaping (FavoriteItem?) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = FavoriteItem(context: context)
        
        item.id = Int64(model.id ?? 0)
        item.name = model.name
        item.rating = Double(model.rating ?? 0.0)
        item.released = model.released
        item.suggestionsCount = Int64(model.suggestionsCount ?? 0)
        item.backgroundImage = model.backgroundImage
        
        
        do {
            try context.save()
            completion(item)
        } catch {
            completion(nil)
        }
    }
    
    
    func getFavoritesVideoGames(completion: @escaping ([FavoriteItem]) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<FavoriteItem>
        
        request = FavoriteItem.fetchRequest()
        
        do {
            
            let videoGames = try context.fetch(request)
            completion(videoGames)
            
        } catch {
            completion([])
        }
    }
    
    func deleteFavorite(model: FavoriteItem, completion: @escaping (Bool)-> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        context.delete(model)
        
        do {
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
        
    }
    
    func addNote(gameId: Int, note: String, completion: @escaping (Bool) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = NoteItem(context: context)
        
        item.gameId = Int64(gameId)
        item.note = note
        
        do {
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    func getNotes(videoGameId: Int, completion: @escaping ([NoteItem]) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<NoteItem>
        
        request = NoteItem.fetchRequest()
        
        do {
            
            let notes = try context.fetch(request)
            let filter = notes.filter { item in
                Int(item.gameId) == videoGameId
            }
            
            completion(filter)
            
        } catch {
            completion([])
        }
    }
    
    func deleteNote(model: NoteItem, completion: @escaping (Bool)-> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        context.delete(model)
        
        do {
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
        
    }
    
    func update(note:String, newNote: String) -> Bool{
               
               guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
               
               let managedContext = appDelegate.persistentContainer.viewContext
               
               let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteItem")
               let predicate = NSPredicate(format: "note = %@", note)
               fetchRequest.predicate = predicate
              
               do{
                   let foundTasks = try managedContext.fetch(fetchRequest) as! [NoteItem]
                   foundTasks.first?.note = newNote
                   try managedContext.save()
                   return true
               }catch{
                       print("update error.")
                   return false
                   }
               }
    
    
}
