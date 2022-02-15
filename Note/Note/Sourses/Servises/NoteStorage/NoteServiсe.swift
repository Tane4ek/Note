//
//  File.swift
//  Note
//
//  Created by Татьяна Лузанова on 10.02.2022.
//

import Foundation
import CoreData

protocol NoteService {
    
    func notes() -> [Note]
    
    func updateNoteIfCan(note: Note) -> Bool

    func deleteNote(noteID: UUID)
    
}

