//
//  EditNoteModel.swift
//  VideoGamesStore
//
//  Created by Burak on 20.01.2023.
//

import Foundation

protocol EditNoteModeldelegate: AnyObject {
    func updateNoteItems(noteItems: [NoteItem])
    func deleteNote()
}

class EditNoteModel {
    weak var delegate: EditNoteModeldelegate?
    
    func addNote(gameId: Int,note: String){
        CoreDataManager.shared.addNote(gameId: gameId, note: note) { state in
            if(!state){ return }
            self.getNotes(videoGameId: gameId)
        }
    }
    
    func getNotes(videoGameId: Int){
        CoreDataManager.shared.getNotes(videoGameId: videoGameId) { noteItems in
            self.delegate?.updateNoteItems(noteItems: noteItems)
        }
    }
    
    func deleteNote( model: NoteItem){
        CoreDataManager.shared.deleteNote(model: model) { state in
            self.delegate?.deleteNote()
        }
    }
}
