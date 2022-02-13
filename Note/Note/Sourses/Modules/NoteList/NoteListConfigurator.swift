//
//  NoteListConfigurator.swift
//  Note
//
//  Created by Татьяна Лузанова on 10.02.2022.
//

import UIKit


final class NoteListModuleConfigurator {
    
    var serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func configure() -> NoteListViewController {
        let presenter = NoteListPresenter()
        let view = NoteListViewController(presenter: presenter)
        let router = NoteListRouter(serviceContainer: serviceContainer)
        
        presenter.view = view
        presenter.router = router
        presenter.noteServise = serviceContainer.noteService
        router.serviceContainer = serviceContainer
        router.view = view
        
        return view
    }
}

