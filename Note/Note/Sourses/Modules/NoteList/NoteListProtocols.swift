//
//  NoteListProtocols.swift
//  Note
//
//  Created by Татьяна Лузанова on 10.02.2022.
//

import Foundation

protocol NoteListViewInput: AnyObject {
    
    func reloadUI()
}

protocol NoteListViewOutput: AnyObject {
    
    func viewWillAppear()
    
    func buttonAddTapped()
    
    func didSelectRowAt(index: Int)
    
    func numberOfItems() -> Int
    
    func modelOfIndex(index: Int) -> Note
}
