//
//  EditNoteViewModel.swift
//  VideoGamesStore
//
//  Created by Burak on 20.01.2023.
//

import Foundation

protocol EditNoteViewModelDelegate: AnyObject {
    func updateNoteList()
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
            //Todo: Add Warning
            print("not boş veya 3 harften az olamaz")
            return
        }
        model.addNote(gameId: gameId ?? 0, note: note)
    }
    
    func deleteNote(row: Int){
        model.deleteNote(model: notes[row])
    }
}

extension EditNoteViewModel: EditNoteModeldelegate {
    func deleteNote() {
        getNotes()
    }
    
    func updateNoteItems(noteItems: [NoteItem]) {
        notes = noteItems
        self.delegate?.updateNoteList()
    }
    
    
}
