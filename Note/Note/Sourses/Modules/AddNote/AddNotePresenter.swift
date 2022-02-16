//
//  AddNotePresenter.swift
//  Note
//
//  Created by Татьяна Лузанова on 11.02.2022.
//


import UIKit

class AddNotePresenter {
    
    weak var view: AddNoteViewInput?
    var router: AddNoteRouter?
    var noteService: NoteService?
    
    var fontStyle: UIFont
    
    var note: Note
    let isEditMode: Bool
    
    init(note: Note?, fontStyle: UIFont){
        self.isEditMode = note != nil
        self.note = note ?? Note(id: UUID(), name: "", text: "", dateOfLastChange: Date.now, styleText: FontStyle.normal.rawValue)
        self.fontStyle = fontStyle
    }
}
extension AddNotePresenter: AddNoteViewOutput {
    
    func viewWillAppear() {
        view?.reloadUI()
    }
    
    func currentModel() -> Note {
        return note
    }
    
    func currentFont() -> UIFont {
        return fontStyle
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
            router?.showAlert(title: "Attension", message: "Note cannot be empty")
            return
        }
        let result = noteService?.updateNoteIfCan(note: note)
        if result  == true {
            router?.returnToNoteListModule()
        }
    }
    
    func addPhotoButtonTapped() {
        router?.showAlert(title: "Add Photo", message: "Will be available soon")
        return
        }
    
    func addNewNoteButtonTapped() {
        let emptyNote = Note(id: UUID(), name: "", text: "", dateOfLastChange: Date.now, styleText: FontStyle.normal.rawValue)
        router?.showAddNoteModule(note: emptyNote)
        }
    
    func deleteNoteButtonTapped() {
            noteService?.deleteNote(noteID: note.id)
            router?.returnToNoteListModule()
    }
    
    func fontForBoldStyle(font: UIFont) {
        if font != FontStyle.bold.font {
            note.styleText = FontStyle.bold.rawValue
            fontStyle = FontStyle.bold.font
        } else if font == FontStyle.bold.font {
            note.styleText = FontStyle.normal.rawValue
            fontStyle = FontStyle.normal.font
        }
    }
    
    func fontForItalicStyle(font: UIFont) {
        if font != FontStyle.italic.font {
            note.styleText = FontStyle.italic.rawValue
            fontStyle = FontStyle.italic.font
        } else if font == FontStyle.italic.font {
            note.styleText = FontStyle.normal.rawValue
            fontStyle = FontStyle.normal.font
        }
    }
    
    func fontForUnderlineStyle() {
        router?.showAlert(title: "Underline style", message: "Will be available soon")
    }
    
    func fontForStrikethroughStyle() {
        router?.showAlert(title: "Strikethrough style", message: "Will be available soon")
    }
    
    func fontForNameStyle(font: UIFont) {
        if font != FontStyle.name.font {
            note.styleText = FontStyle.name.rawValue
            fontStyle = FontStyle.name.font
        } else if font == FontStyle.name.font {
            note.styleText = FontStyle.normal.rawValue
            fontStyle = FontStyle.normal.font
        }
    }
    
    func fontForTitleStyle(font: UIFont) {
        if font != FontStyle.title.font {
            note.styleText = FontStyle.title.rawValue
            fontStyle = FontStyle.title.font
        } else if font == FontStyle.title.font {
            note.styleText = FontStyle.normal.rawValue
            fontStyle = FontStyle.normal.font
        }
    }
    
    func fontForSubTitleStyle(font: UIFont) {
        if font != FontStyle.subTitle.font {
            note.styleText = FontStyle.subTitle.rawValue
            fontStyle = FontStyle.subTitle.font
        } else if font == FontStyle.subTitle.font {
            note.styleText = FontStyle.normal.rawValue
            fontStyle = FontStyle.normal.font
        }
    }
    
    func fontForMainTextStyle(font: UIFont) {
        if font != FontStyle.normal.font {
            note.styleText = FontStyle.normal.rawValue
            fontStyle = FontStyle.normal.font
        } 
    }
}




