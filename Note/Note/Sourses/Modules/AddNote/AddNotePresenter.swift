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
    
    var note: Note
    let isEditMode: Bool
    
    init(note: Note?){
        self.isEditMode = note != nil
        self.note = note ?? Note(id: UUID(),
                                 name: "",
                                 text: "",
                                 dateOfLastChange: Date.now,
                                 styleText: FontStyle.normal.rawValue,
                                 textColor: TextColor.normal.rawValue)
    }
}
extension AddNotePresenter: AddNoteViewOutput {
    
    func currentModel() -> Note {
        return note
    }
    
    func currentColor() -> UIColor? {
        return TextColor(rawValue: note.textColor)?.color
    }
    
    func currentFont() -> UIFont? {
        return FontStyle(rawValue: note.styleText)?.font
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
        let emptyNote = Note(id: UUID(),
                             name: "",
                             text: "",
                             dateOfLastChange: Date.now,
                             styleText: FontStyle.normal.rawValue,
                             textColor: TextColor.normal.rawValue)
        router?.showAddNoteModule(note: emptyNote)
        }
    
    func deleteNoteButtonTapped() {
            noteService?.deleteNote(noteID: note.id)
            router?.returnToNoteListModule()
    }
    
    func fontForBoldStyle() {
        if note.styleText != FontStyle.bold.rawValue {
            note.styleText = FontStyle.bold.rawValue
        } else {
            note.styleText = FontStyle.normal.rawValue
        }
        view?.updateFont()
    }
    
    func fontForItalicStyle() {
        if note.styleText != FontStyle.italic.rawValue {
            note.styleText = FontStyle.italic.rawValue
        } else {
            note.styleText = FontStyle.normal.rawValue
        }
        view?.updateFont()
    }
    
    func fontForUnderlineStyle() {
        router?.showAlert(title: "Underline style", message: "Will be available soon")
    }
    
    func fontForStrikethroughStyle() {
        router?.showAlert(title: "Strikethrough style", message: "Will be available soon")
    }
    
    func fontForNameStyle() {
        if note.styleText != FontStyle.name.rawValue {
            note.styleText = FontStyle.name.rawValue
        } else {
            note.styleText = FontStyle.normal.rawValue
        }
        view?.updateFont()
    }
    
    func fontForTitleStyle() {
        if note.styleText != FontStyle.title.rawValue {
            note.styleText = FontStyle.title.rawValue
        } else {
            note.styleText = FontStyle.normal.rawValue
        }
        view?.updateFont()
    }
    
    func fontForSubTitleStyle() {
        if note.styleText != FontStyle.subTitle.rawValue {
            note.styleText = FontStyle.subTitle.rawValue
        } else {
            note.styleText = FontStyle.normal.rawValue
        }
        view?.updateFont()
    }
    
    func fontForMainTextStyle() {
        if note.styleText != FontStyle.normal.rawValue {
            note.styleText = FontStyle.normal.rawValue
        }
        view?.updateFont()
    }
    
    func changeTextColor() {
        if note.textColor != TextColor.coral.rawValue {
            note.textColor = TextColor.coral.rawValue
        } else {
            note.textColor = TextColor.normal.rawValue
        }
        view?.changeTextColor()
    }
}




