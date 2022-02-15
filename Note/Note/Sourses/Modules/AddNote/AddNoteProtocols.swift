//
//  AddNoteProtocols.swift
//  Note
//
//  Created by Татьяна Лузанова on 10.02.2022.
//

import Foundation

protocol BottomStackViewDelegate {
    
    func addPhotoButtonTapped()
    
    func changeTextStyleButtonTapped()
    
    func addNewNoteButtonTapped()
    
    func deleteNoteButtonTapped() 
}

protocol BottomStyleViewDelegate {
    
    func closeButtonTapped()
    
    func buttonPaintbrushTapped()
    
    func nameButtonTapped()
    
    func titleButtonTapped()
    
    func subTitleButtonTapped()
    
    func mainTextButtonTapped()
    
    func boldFontButtonTapped()
    
    func italicFontButtonTapped()
    
    func underlineFontButtonTapped()
    
    func strikethroughFontButtonTapped() 
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
    
    func addNewNoteButtonTapped()
    
    func deleteNoteButtonTapped() 
}

