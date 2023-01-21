//
//  EditNoteViewModel.swift
//  VideoGamesStore
//
//  Created by Burak on 20.01.2023.
//

import Foundation

protocol EditNoteViewModelDelegate: AnyObject {
    func updateNoteList()
    func showAlert()
}

class EditNoteViewModel {
    weak var delegate: EditNoteViewModelDelegate?
    
    private let model : EditNoteModel = EditNoteModel()
    
    var gameId: Int?
    
    var notes: [NoteItem] = []
    
    init(){
        model.delegate = self
    }
    
    func getNotes(){
        model.getNotes(videoGameId: gameId ?? 0)
    }
    
    func addNote(note: String){
        if(note.count < 3 ){
            self.delegate?.showAlert()
            return
        }
        model.addNote(gameId: gameId ?? 0, note: note)
    }
    
    func deleteNote(row: Int){
        model.deleteNote(model: notes[row])
    }
    
    func updateNote(note:String, newNote: String){
        model.updateNote(note: note, newNote: newNote)
    }
    
}

extension EditNoteViewModel: EditNoteModeldelegate {
    func updateNote(state: Bool) {
        getNotes()
    }
    
    func deleteNote() {
        getNotes()
    }
    
    func updateNoteItems(noteItems: [NoteItem]) {
        notes = noteItems
        self.delegate?.updateNoteList()
    }
    
    
}
