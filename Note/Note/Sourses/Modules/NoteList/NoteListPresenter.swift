//
//  NoteListPresenter.swift
//  Note
//
//  Created by Татьяна Лузанова on 10.02.2022.
//

import Foundation

class NoteListPresenter {
    
    weak var view: NoteListViewInput?
    var models: [Note] = []
    var router: NoteListRouter?
    var noteServiсe: NoteService?
    
}

extension NoteListPresenter: NoteListViewOutput {
    
    func viewWillAppear() {
        models = noteServiсe?.notes() ?? []
        view?.reloadUI()
    }
    
    func didSelectRowAt(index: Int) {
        let currentNote = models[index]
        router?.showAddNoteModule(note: currentNote)
    }
    
    func buttonAddTapped() {
        let emptyNote = Note(
            id: UUID(),
            name: "",
            text: "",
            dateOfLastChange: Date.now,
            styleText: FontStyle.normal.rawValue,
            textColor: TextColor.normal.rawValue)
        router?.showAddNoteModule(note: emptyNote)
    }
    
    func numberOfItems() -> Int {
        return models.count
    }
    
    func modelOfIndex(index: Int) -> Note {
        let currentModel = models[index]
        return currentModel
    }
}
