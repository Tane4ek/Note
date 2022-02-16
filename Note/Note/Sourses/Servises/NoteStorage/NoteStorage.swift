//
//  NoteStorage.swift
//  Note
//
//  Created by Татьяна Лузанова on 10.02.2022.
//

import Foundation
import UIKit
import CoreData

protocol NoteStorage {
    
    func saveToDataBase(note: Note)
    
    func notesFromDataBase() -> [Note]
    
    func createRequestForNoteID(noteID: UUID) -> NSFetchRequest<Notes>
    
    func deleteFromDataBase(noteID: UUID)
    
    func updateInDataBase(note: Note)

}


class NoteStorageImpl {
   
    var storedUserNotes: [Notes] = []
    
    func createManagedContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        return managedContext
    }
    
    func createRequestForNoteID(noteID: UUID) -> NSFetchRequest<Notes> {
        let fetchRequest: NSFetchRequest<Notes> = Notes.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", noteID as CVarArg)
        return fetchRequest
    }
    
  }

extension NoteStorageImpl: NoteStorage {
   
    func saveToDataBase(note: Note) {
//         Создать ManagedObject из Note и сохранить его
        
        let managedContext = createManagedContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "Notes", in: managedContext!)!
        let userNote = Notes(entity: entity, insertInto: managedContext)
        
        userNote.name = note.name
        userNote.id = note.id
        userNote.text = note.text
        userNote.date = note.dateOfLastChange
        userNote.textStyle = note.styleText
        
        do {
            try managedContext?.save()
            storedUserNotes.append(userNote)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func notesFromDataBase() -> [Note] {
// Получить все ManagedObject и конвертировать их в [Note]
        var notesFromDB: [Note] = []
        let managedContext = createManagedContext()
        
        let fetchRequest: NSFetchRequest<Notes> = Notes.fetchRequest()
        do {
            storedUserNotes = try managedContext!.fetch(fetchRequest)
            storedUserNotes.forEach { let note = Note(id: $0.id ?? UUID(), name: $0.name ?? "", text: $0.text ?? "", dateOfLastChange: $0.date ?? Date.now, styleText: $0.textStyle ?? "mainText")
                
                notesFromDB.append(note)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return notesFromDB
    }
    
    func deleteFromDataBase(noteID: UUID) {
//        удаляем записку из ManagedObject
        let managedContext = createManagedContext()
        let fetchRequest = createRequestForNoteID(noteID: noteID)
        
        storedUserNotes = try! managedContext!.fetch(fetchRequest)
        
        if storedUserNotes.count != 0 {
            managedContext!.delete(storedUserNotes.first!)
            
            do {
                try managedContext!.save()
            } catch let error as NSError {
                print("Could not delete. \(error), \(error.userInfo)")
            }
        }
    }
    
    func updateInDataBase(note: Note) {
        let managedContext = createManagedContext()
        let fetchRequest = createRequestForNoteID(noteID: note.id)
        
        storedUserNotes = try! managedContext!.fetch(fetchRequest)
        
        storedUserNotes.first?.name = note.name
        storedUserNotes.first?.text = note.text
        storedUserNotes.first?.textStyle = note.styleText
        
        do {
            try managedContext!.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
