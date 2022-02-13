//
//  AddNotePresenter.swift
//  Note
//
//  Created by Татьяна Лузанова on 11.02.2022.
//

import Foundation
class AddNotePresenter {
    
    weak var view: AddNoteViewInput?
    var router: AddNoteRouter?
    var noteService: NoteService?
    
    var note: Note
    let isEditMode: Bool
    
    init(note: Note?){
        self.isEditMode = note != nil
        self.note = note ?? Note(id: UUID(), name: "", text: "", dateOfLastChange: Date.now)
    }
}

extension AddNotePresenter: AddNoteViewOutput {
    
    func viewWillAppear() {
        view?.reloadUI()
    }
    
    func currentModel() -> Note {
        return note
    }
    
    func addTitle(title: String) {
        note.name = title
        print("add title", note)
    }
    
    func addNote(note: String) {
        self.note.text = note
        print("Add note", note)
    }
    
    func buttonBackTapped() {
        router?.returnToNoteListModule()
    }
    
    func buttonDoneTapped() {
        if note.name.isEmpty && note.text.isEmpty {
            router?.showAlert()
            return
        }
        let result = noteService?.updateNoteIfCan(note: note)
        if result  == true {
            router?.returnToNoteListModule()
        }
    }
    
    func addPhotoButtonTapped() {
        router?.showPhotoAlert()
        return
        }
    
    func changeTextStyleButtonTapped() {
        router?.showTextStyleModule()
        }
    
    func addNewNoteButtonTapped() {
            
        }
    
    func deleteNoteButtonTapped() {
            noteService?.deleteNote(noteID: note.id)
            router?.returnToNoteListModule()
    }
    
}
