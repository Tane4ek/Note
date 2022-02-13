//
//  AddNoteConfigurator.swift
//  Note
//
//  Created by Татьяна Лузанова on 11.02.2022.
//

import Foundation

final class AddNoteModuleConfigurator {
    
    var serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func configure(note: Note?) -> AddNoteViewController {
        let presenter = AddNotePresenter(note: note)
        let view = AddNoteViewController(presenter: presenter)
        let router = AddNoteRouter(serviceContainer: serviceContainer)

        presenter.view = view
        presenter.router = router
        presenter.noteService = serviceContainer.noteService
        router.serviceContainer = serviceContainer
        router.view = view

        return view
    }
}
