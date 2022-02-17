//
//  AddNoteProtocols.swift
//  Note
//
//  Created by Татьяна Лузанова on 10.02.2022.
//

import UIKit

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
    
    func changeTextColor()
    
    func updateFont()
}

protocol AddNoteViewOutput: AnyObject {
    
    func currentModel() -> Note
    
    func currentFont() -> UIFont?
    
    func currentColor() -> UIColor?
    
    func addTitle(title: String)

    func addNote(note: String)
    
    func buttonBackTapped()
    
    func buttonDoneTapped()
    
    func addPhotoButtonTapped()
    
    func addNewNoteButtonTapped()
    
    func deleteNoteButtonTapped()
    
    func fontForBoldStyle()
    
    func fontForItalicStyle()
    
    func fontForUnderlineStyle()
    
    func fontForStrikethroughStyle()
    
    func fontForNameStyle()
    
    func fontForTitleStyle()
    
    func fontForSubTitleStyle()
    
    func fontForMainTextStyle()
    
    func changeTextColor()
}

