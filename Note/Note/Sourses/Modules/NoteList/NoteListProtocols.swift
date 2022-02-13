//
//  NoteListProtocols.swift
//  Note
//
//  Created by Татьяна Лузанова on 10.02.2022.
//

import Foundation
import UIKit

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

protocol SwipeableCollectionViewCellDelegate: AnyObject {
    func hiddenConteinerViewTapped(inCell cell: UICollectionViewCell)
}
