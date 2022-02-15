//
//  NoteServiseImpl.swift
//  Note
//
//  Created by Татьяна Лузанова on 10.02.2022.
//
import Foundation
import UIKit

class NoteServiceImpl {
    
    var userNotes: [Note] = []

    
    var noteStorageImpl: NoteStorageImpl
//
    init(noteStorageImpl: NoteStorageImpl) {
        self.noteStorageImpl = noteStorageImpl
    }
}

extension NoteServiceImpl: NoteService {
    
    func notes() -> [Note] {
//        let firstNote = Note(id: UUID(), name: "First", text: "Is is my first note", dateOfLastChange: Date.now)
//        userNotes.append(firstNote)
//        return userNotes
        
        
        return noteStorageImpl.notesFromDataBase()
    }
    
    func updateNoteIfCan(note: Note) -> Bool {
        guard userNotes.contains(where: { $0.name == note.name && $0.id != note.id}
        ) == false
        else { return false }
        
        var needAppear = true
        userNotes = noteStorageImpl.notesFromDataBase()
        for i in 0..<userNotes.count {
            if userNotes[i].id == note.id {
                userNotes[i] = note
                needAppear = false
                
                noteStorageImpl.updateInDataBase(note: note)
                break
            }
        }
        if needAppear {
            userNotes.append(note)
            noteStorageImpl.saveToDataBase(note: note)
        }
        return true
    }
    
    func deleteNote(noteID: UUID) {
        noteStorageImpl.deleteFromDataBase(noteID: noteID)
        for i in 0..<userNotes.count {
            print("заметки до удаления \(userNotes)")
            if userNotes[i].id == noteID {
                userNotes.remove(at: i)
                
                break
            }
        }
        print("заметки после удаления \(userNotes)")
        
    }
}
