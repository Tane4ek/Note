//
//  AddNoteProtocols.swift
//  Note
//
//  Created by Татьяна Лузанова on 10.02.2022.
//

import Foundation

protocol TextInputCollectionViewCellDelegate {
    
    func getData (data: String, index: Int)
    
    func dataTransfer(index: Int)
}

protocol AddNoteViewInput: AnyObject {
    
    func reloadUI()
}

protocol AddNoteViewOutput: AnyObject {
    
    func viewWillAppear()
    
    func currentModel () -> Note
    
    func addTitle(title: String)

    func addNote(note: String)
    
    func buttonBackTapped()
    
    func buttonDoneTapped()
    
    func addPhotoButtonTapped()
    
    func changeTextStyleButtonTapped()
    
    func addNewNoteButtonTapped()
    
    func deleteNoteButtonTapped() 
}

