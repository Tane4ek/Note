//
//  NoteListRouter.swift
//  Note
//
//  Created by Татьяна Лузанова on 10.02.2022.
//

import Foundation

import UIKit

class NoteListRouter {
    
    weak var view: UIViewController?
    var serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func showAddNoteModule(note: Note) {
        let configurator = AddNoteModuleConfigurator(serviceContainer: serviceContainer)
        let addNoteViewController = configurator.configure(note: note)
        view?.navigationController?.pushViewController(addNoteViewController, animated: true)
    }
}
